import 'dart:io';

import 'package:app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLoader extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  final Color color;
  final Color background;
  final double iconSize;

  const ButtonLoader({
    this.width,
    this.radius = 08,
    this.height = 48,
    this.color = white,
    this.iconSize = 20,
    this.background = primary,
  });

  @override
  Widget build(BuildContext context) {
    var iosLoader = const CupertinoActivityIndicator(color: white, radius: 14);
    var androidLoader = CircularProgressIndicator(color: white, backgroundColor: white.withOpacity(0.3));
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      child: Platform.isIOS ? iosLoader : SizedBox(height: 24, width: 24, child: androidLoader),
    );
  }
}
