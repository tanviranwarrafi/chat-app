import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ImageService {
  Future<Uint8List?> fileToUnit8List(File file) async => (await file.readAsBytes()).buffer.asUint8List();

  Future<Uint8List?> UrlToUnit8List(String url) async => (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();

  Future<Uint8List> getBytesFromAsset({required String path}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 50, targetHeight: 50);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<ui.Image> fileToUiImage(File image) async {
    var imageBytes = await image.readAsBytes();
    var uiImage = await decodeImageFromList(imageBytes);
    return uiImage;
  }
}
