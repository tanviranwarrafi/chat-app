import 'dart:io';

import 'package:app/chat_app.dart';
import 'package:app/screen_craft.dart';
import 'package:app/services/http_overrides.dart';
import 'package:app/services/providers.dart';
import 'package:app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'di.dart' as dependency_injection;

Future<void> main() async {
  await dependency_injection.init();
  await _initChatApp();
  runApp(MultiProvider(providers: providers, child: _screenCraft()));
}

Widget _screenCraft() => ScreenCraft(builder: (context, orientation) => ChatApp());

Future<void> _initChatApp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await portraitMode();
}
