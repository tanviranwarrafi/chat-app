import 'package:app/themes/colors.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final String label;
  final String? icon;
  final double? width;
  final double height;
  final double radius;
  final Color color;
  final Color background;
  final Color? iconColor;
  final double padding;
  final double textSize;
  final double iconSize;
  final List<BoxShadow> shadow;
  final Function()? onTap;

  const OutlineButton({
    this.onTap,
    this.label = '',
    this.width,
    this.icon,
    this.radius = 08,
    this.height = 48,
    this.padding = 12,
    this.color = grey1,
    this.textSize = 16.5,
    this.iconSize = 20,
    this.iconColor,
    this.background = white,
    this.shadow = const [SHADOW_1],
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadow,
          border: Border.all(color: offWhite1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) SvgImage(image: icon!, height: iconSize, color: iconColor),
            if (icon != null) const SizedBox(width: 08),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text15_500.copyWith(color: color, fontSize: textSize, height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
