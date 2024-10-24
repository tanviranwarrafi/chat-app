import 'package:app/constants/app_constants.dart';
import 'package:app/features/introduction/splash_screen.dart';
import 'package:app/services/lifecycle_observer.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/light_theme.dart';
import 'package:app/utils/keys.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatefulWidget {
  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  var _observer = LifecycleObserver();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(_observer);
    return MaterialApp(
      color: primary,
      title: APP_NAME,
      theme: LIGHT_THEME,
      home: SplashScreen(),
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
