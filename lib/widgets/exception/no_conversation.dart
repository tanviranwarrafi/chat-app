import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:flutter/material.dart';

class NoConversation extends StatelessWidget {
  final double topGap;
  final double bottomGap;

  const NoConversation({this.topGap = 40, this.bottomGap = 32});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topGap),
        Image.asset(Assets.png_image.chat_orange, height: 154),
        const SizedBox(height: 20),
        Text(
          'Sorry! No Conversation Yet.',
          textAlign: TextAlign.center,
          style: TextStyles.text18_600.copyWith(color: grey1),
        ),
        const SizedBox(height: 08),
        Text(
          'Tap on the Company heads on top to start chatting',
          textAlign: TextAlign.center,
          style: TextStyles.text14_400.copyWith(color: grey2),
        ),
        SizedBox(height: bottomGap),
      ],
    );
  }
}
