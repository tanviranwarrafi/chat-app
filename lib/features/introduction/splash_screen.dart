import 'dart:async';

import 'package:app/extensions/flutter_ext.dart';
import 'package:app/services/routes.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/core/pop_scope_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      return unawaited(Routes.chat_buddies().pushAndRemove());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SizeConfig.initMediaQuery(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeNavigator(
      canPop: false,
      child: Scaffold(
        body: Container(
          width: SizeConfig.width,
          height: SizeConfig.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 80),
          child: Text('CHAT APP', style: TextStyles.text24_600.copyWith(fontSize: 40, color: primary, fontWeight: w900)),
        ),
      ),
    );
  }
}
