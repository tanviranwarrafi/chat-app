import 'dart:io' as platform;

import 'package:app/constants/app_constants.dart';
import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/utils/keys.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/utils/transitions.dart';
import 'package:app/widgets/core/pop_scope_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> appExitDialog() async {
  var context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierLabel: 'App Exit Dialog',
    transitionDuration: DIALOG_DURATION,
    transitionBuilder: sl<Transitions>().topToBottom,
    pageBuilder: (buildContext, anim1, anim2) => PopScopeNavigator(canPop: false, child: Align(child: _DialogView())),
  );
}

class _DialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.dialog_width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.dialog_padding, vertical: Dimensions.dialog_padding),
      decoration: BoxDecoration(color: white, borderRadius: DIALOG_RADIUS, boxShadow: const [SHADOW_3]),
      child: Material(color: transparent, child: _screenView(context), shape: DIALOG_SHAPE),
    );
  }

  Widget _screenView(BuildContext context) {
    var isMobile = SizeConfig.isMobile;
    var size = Size(double.infinity, isMobile ? 44 : 50);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Image.asset(Assets.png_image.door_open, height: 140),
        const SizedBox(height: 32),
        Text('Exit $APP_NAME?', textAlign: TextAlign.center, style: TextStyles.text24_600.copyWith(color: dark)),
        const SizedBox(height: 08),
        Text(
          'Are you sure you want to close the application?',
          textAlign: TextAlign.center,
          style: TextStyles.text15_500.copyWith(color: grey2),
        ),
        const SizedBox(height: 28),
        OutlinedButton(
          onPressed: () => platform.Platform.isAndroid ? SystemNavigator.pop() : platform.exit(0),
          child: const Text('Yes, Exit', style: TextStyle(color: error)),
          style: OutlinedButton.styleFrom(minimumSize: size, maximumSize: size),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: backToPrevious,
          child: Text('No, Stay', style: TextStyle(fontSize: isMobile ? 16 : 18)),
          style: ElevatedButton.styleFrom(minimumSize: size, maximumSize: size),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
