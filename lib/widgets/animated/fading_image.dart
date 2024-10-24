import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FadingImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const FadingImage({required this.image, this.width, this.height, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: SvgPicture.asset(image, fit: fit, height: height, width: width, key: ValueKey(image)),
    );
  }
}
