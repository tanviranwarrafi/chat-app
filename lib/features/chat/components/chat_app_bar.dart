import 'package:app/components/loaders/fading_circle.dart';
import 'package:app/components/menus/back_menu.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final ChatBuddy buddy;
  final bool status;
  final Function()? onMoreVert;

  const ChatAppBar({required this.buddy, this.status = false, this.onMoreVert});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackMenu(onTap: backToPrevious),
        const SizedBox(width: 12),
        CircleImage(
          radius: 17,
          borderWidth: 0.5,
          borderColor: grey3,
          image: buddy.user?.avatar,
          placeholder: const FadingCircle(size: 20),
          errorWidget: Image.asset(Assets.png_image.profile, height: 34),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(buddy.user?.name ?? '', style: TextStyles.text18_600.copyWith(color: grey1, height: 1.2))),
        const SizedBox(width: 12),
        InkWell(onTap: onMoreVert, child: SvgImage(image: Assets.svg.dots_three_vertical, height: 24, color: grey1)),
      ],
    );
  }
}
