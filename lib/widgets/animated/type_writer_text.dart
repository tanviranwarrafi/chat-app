import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  const TypewriterText({required this.text});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  final _typingDuration = const Duration(milliseconds: 100);
  final _deletingDuration = const Duration(milliseconds: 100);
  late String _displayedText;
  late String _incomingText;
  late String _outgoingText;

  @override
  void initState() {
    _incomingText = widget.text;
    _outgoingText = '';
    _displayedText = '';
    animateText();
    super.initState();
  }

  Future<void> animateText() async {
    final backwardLength = _outgoingText.length;
    if (backwardLength > 0) {
      for (var i = backwardLength; i >= 0; i--) {
        await Future.delayed(_deletingDuration);
        _displayedText = _outgoingText.substring(0, i);
        setState(() {});
      }
    }
    final forwardLength = _incomingText.length;
    if (forwardLength > 0) {
      for (var i = 0; i <= forwardLength; i++) {
        await Future.delayed(_typingDuration);
        _displayedText = _incomingText.substring(0, i);
        setState(() {});
      }
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    if (oldWidget.text != widget.text) {
      _outgoingText = oldWidget.text;
      _incomingText = widget.text;
      animateText();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 50,
        color: white,
        fontWeight: w900,
        fontFamily: archivo,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
