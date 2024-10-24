import 'package:app/animations/core/animation_text.dart';
import 'package:flutter/material.dart';

class ScaleAnimatedText extends AnimationText {
  final double scalingFactor;

  ScaleAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.scalingFactor = 0.5,
  }) : super(text: text, textAlign: textAlign, textStyle: textStyle, duration: duration);

  late Animation<double> _fadeIn, _fadeOut, _scaleIn, _scaleOut;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.5, curve: Curves.easeOut)),
    );

    _fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 1, curve: Curves.easeOut)),
    );

    _scaleIn = Tween<double>(begin: scalingFactor, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.5, curve: Curves.easeOut)),
    );
    _scaleOut = Tween<double>(begin: 1, end: scalingFactor).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 1, curve: Curves.easeIn)),
    );
  }

  @override
  Widget completeText(BuildContext context) => textWidget(text);

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return ScaleTransition(
      scale: _scaleIn.value != 1.0 ? _scaleIn : _scaleOut,
      child: Opacity(opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value, child: textWidget(text)),
    );
  }
}
