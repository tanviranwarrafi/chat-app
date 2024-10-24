import 'package:app/extensions/flutter_ext.dart';
import 'package:app/themes/colors.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

class BackMenu extends StatelessWidget {
  final double left;
  final double size;
  final Color color;
  final Function()? onTap;

  const BackMenu({this.size = 24, this.onTap, this.color = grey1, this.left = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? backToPrevious,
      child: Padding(
        padding: EdgeInsets.only(left: left),
        child: SvgImage(image: Assets.svg.arrow_left, color: color, height: size, fit: BoxFit.cover),
      ),
    );
  }
}
