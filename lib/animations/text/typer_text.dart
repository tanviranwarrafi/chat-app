import 'package:app/animations/core/animation_text.dart';
import 'package:flutter/material.dart';

class TyperText extends AnimationText {
  final Duration speed;
  final Curve curve;

  TyperText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    this.speed = const Duration(milliseconds: 60),
    this.curve = Curves.linear,
  }) : super(text: text, textAlign: textAlign, textStyle: style, duration: speed * text.characters.length);

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(curve: curve).animate(controller);
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final count = (_typingText.value.clamp(0, 1) * textCharacters.length).round();
    assert(count <= textCharacters.length);
    return textWidget(textCharacters.take(count).toString());
  }
}
