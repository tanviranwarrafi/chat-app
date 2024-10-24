import 'package:flutter/material.dart';

abstract class AnimationText {
  final String text;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final Duration duration;
  final Characters textCharacters;

  AnimationText({
    required this.text,
    required this.duration,
    this.textAlign = TextAlign.start,
    this.textStyle,
  }) : textCharacters = text.characters;

  Duration? get remaining => null;
  void initAnimation(AnimationController controller);
  Widget textWidget(String data) => Text(data, textAlign: textAlign, style: textStyle);
  Widget completeText(BuildContext context) => textWidget(text);
  Widget animatedBuilder(BuildContext context, Widget? child);
}
