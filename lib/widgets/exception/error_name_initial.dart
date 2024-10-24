import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

class ErrorNameInitial extends StatelessWidget {
  final String initial;
  final double fontSize;
  final double iconSize;
  final double fontHeight;
  const ErrorNameInitial({this.initial = '', this.fontSize = 20, this.iconSize = 24, this.fontHeight = 1.6});

  @override
  Widget build(BuildContext context) {
    if (initial.isEmpty) {
      return Center(child: SvgImage(image: Assets.svg.user_1, height: iconSize, color: grey3));
    } else {
      return Center(
        child: Text(
          initial,
          style: TextStyles.text24_600.copyWith(
            height: fontHeight,
            color: grey3,
            fontSize: fontSize,
            fontWeight: w600,
          ),
        ),
      );
    }
  }
}
