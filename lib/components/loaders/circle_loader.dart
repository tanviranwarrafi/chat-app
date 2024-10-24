import 'dart:io';

import 'package:app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleLoader extends StatelessWidget {
  final Color color;
  const CircleLoader({this.color = primary});

  @override
  Widget build(BuildContext context) {
    var size = const Size(30, 30);
    var iosLoader = CupertinoActivityIndicator(color: color, radius: 20);
    var androidLoader = CircularProgressIndicator(color: color, backgroundColor: color.withOpacity(0.3));
    return Platform.isIOS ? iosLoader : Center(child: SizedBox(height: size.height, width: size.width, child: androidLoader));
  }
}
