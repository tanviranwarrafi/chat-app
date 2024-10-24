import 'package:app/components/loaders/fading_circle.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

class ChatUserInfo extends StatelessWidget {
  final ChatBuddy buddy;
  const ChatUserInfo({required this.buddy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleImage(
          radius: 36,
          borderWidth: 1,
          borderColor: grey3,
          image: buddy.user?.avatar,
          placeholder: const FadingCircle(size: 32),
          errorWidget: Image.asset(Assets.png_image.profile, height: 72),
        ),
        const SizedBox(height: 12),
        Text(buddy.name ?? '', textAlign: TextAlign.center, style: TextStyles.text18_600.copyWith(color: grey1)),
        const SizedBox(height: 06),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(image: Assets.svg.map_pin, color: primary, height: 16),
            const SizedBox(width: 03),
            Flexible(
              child: Text(
                'tanviranwarrafi@gmail.com',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text14_500.copyWith(color: grey2, height: 1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
