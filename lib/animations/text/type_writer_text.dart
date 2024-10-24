import 'package:app/animations/core/animation_text.dart';
import 'package:app/themes/colors.dart';
import 'package:flutter/material.dart';

class TypewriterText extends AnimationText {
  static const extraLengthForBlinks = 8;
  final Duration speed;
  final Curve curve;
  final String cursor;

  TypewriterText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 30),
    this.curve = Curves.linear,
    this.cursor = '_',
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * (text.characters.length + extraLengthForBlinks),
        );

  late Animation<double> _typewriterText;

  @override
  Duration get remaining => speed * (textCharacters.length + extraLengthForBlinks - _typewriterText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typewriterText = CurveTween(curve: curve).animate(controller);
  }

  @override
  Widget completeText(BuildContext context) => RichText(
        text: TextSpan(
          children: [TextSpan(text: text), TextSpan(text: cursor, style: const TextStyle(color: Colors.transparent))],
          style: DefaultTextStyle.of(context).style.merge(textStyle),
        ),
        textAlign: textAlign,
      );

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final textLen = textCharacters.length;
    final typewriterValue = (_typewriterText.value.clamp(0, 1) * (textCharacters.length + extraLengthForBlinks)).round();

    var showCursor = true;
    var visibleString = text;
    if (typewriterValue == 0) {
      visibleString = '';
      showCursor = false;
    } else if (typewriterValue > textLen) {
      showCursor = (typewriterValue - textLen) % 2 == 0;
    } else {
      visibleString = textCharacters.take(typewriterValue).toString();
    }

    return RichText(
      text: TextSpan(
        children: [TextSpan(text: visibleString), TextSpan(text: cursor, style: showCursor ? null : const TextStyle(color: transparent))],
        style: DefaultTextStyle.of(context).style.merge(textStyle),
      ),
      textAlign: textAlign,
    );
  }
}
