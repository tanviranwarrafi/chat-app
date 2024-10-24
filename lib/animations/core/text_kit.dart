import 'dart:async';
import 'dart:math';

import 'package:app/animations/core/animation_text.dart';
import 'package:flutter/material.dart';

class TextKit extends StatefulWidget {
  final AnimationText text;
  final Duration pause;
  final bool displayFullTextOnTap;
  final bool stopPauseOnTap;
  final VoidCallback? onTap;
  final VoidCallback? onFinished;
  final bool isRepeatingAnimation;
  final bool repeatForever;
  final int totalRepeatCount;

  const TextKit({
    required this.text,
    Key? key,
    this.pause = const Duration(milliseconds: 1000),
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
    this.onTap,
    this.onFinished,
    this.isRepeatingAnimation = true,
    this.totalRepeatCount = 1,
    this.repeatForever = false,
  })  : assert(!isRepeatingAnimation || totalRepeatCount > 0 || repeatForever),
        assert(null == onFinished || !repeatForever),
        super(key: key);

  @override
  _TextKitState createState() => _TextKitState();
}

class _TextKitState extends State<TextKit> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationText _currentAnimatedText;
  var _currentRepeatCount = 0;
  var _isCurrentlyPausing = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completeText = _currentAnimatedText.completeText(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: _isCurrentlyPausing || !_controller.isAnimating
          ? completeText
          : AnimatedBuilder(animation: _controller, builder: _currentAnimatedText.animatedBuilder, child: completeText),
    );
  }

  void _nextAnimation() {
    _isCurrentlyPausing = false;
    if (widget.isRepeatingAnimation && (widget.repeatForever || _currentRepeatCount != (widget.totalRepeatCount - 1))) {
      if (!widget.repeatForever) _currentRepeatCount++;
    } else {
      widget.onFinished?.call();
      return;
    }
    if (mounted) setState(() {});
    _controller.dispose();
    _initAnimation();
  }

  void _initAnimation() {
    _currentAnimatedText = widget.text;
    _controller = AnimationController(duration: _currentAnimatedText.duration, vsync: this);
    _currentAnimatedText.initAnimation(_controller);
    _controller
      ..addStatusListener(_animationEndCallback)
      ..forward();
  }

  void _setPause() {
    _isCurrentlyPausing = true;
    if (mounted) setState(() {});
  }

  void _animationEndCallback(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      assert(null == _timer || !_timer!.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        final left = (_currentAnimatedText.remaining ?? _currentAnimatedText.duration).inMilliseconds;
        _controller.stop();
        _setPause();
        assert(null == _timer || !_timer!.isActive);
        _timer = Timer(Duration(milliseconds: max(widget.pause.inMilliseconds, left)), _nextAnimation);
      }
    }
    widget.onTap?.call();
  }
}
