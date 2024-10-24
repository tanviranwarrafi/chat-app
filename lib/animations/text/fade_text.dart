import 'package:app/animations/core/animation_text.dart';
import 'package:flutter/material.dart';

class FadeText extends AnimationText {
  final double fadeInEnd;
  final double fadeOutBegin;

  FadeText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.fadeInEnd = 0.5,
    this.fadeOutBegin = 0.8,
  })  : assert(fadeInEnd < fadeOutBegin, 'The "fadeInEnd" argument must be less than "fadeOutBegin"'),
        super(text: text, textAlign: textAlign, textStyle: textStyle, duration: duration);

  late Animation<double> _fadeIn, _fadeOut;

  @override
  void initAnimation(AnimationController controller) {
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Interval(0, fadeInEnd)),
    );

    _fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Interval(fadeOutBegin, 1)),
    );
  }

  @override
  Widget completeText(BuildContext context) => textWidget(text);

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
      child: textWidget(text),
    );
  }
}
