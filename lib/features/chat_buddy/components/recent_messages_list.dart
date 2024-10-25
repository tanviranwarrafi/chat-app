import 'package:app/animations/tween_list_item.dart';
import 'package:app/components/loaders/fading_circle.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/services/routes.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:flutter/material.dart';

class RecentMessagesList extends StatelessWidget {
  final List<ChatBuddy> buddies;

  const RecentMessagesList({required this.buddies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      itemCount: buddies.length,
      itemBuilder: _messageItemCard,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _messageItemCard(BuildContext context, int index) {
    var buddy = buddies[index];
    var isUnread = true;
    // var isUnread = buddy.readT == null;
    return TweenListItem(
      index: index,
      child: InkWell(
        key: Key('$index'),
        onTap: Routes.chat(buddy: buddy).push,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(border: index == buddies.length - 1 ? null : const Border(bottom: BorderSide(color: offWhite1))),
          child: Row(
            children: [
              CircleImage(
                borderWidth: 1,
                borderColor: grey3,
                placeholder: const FadingCircle(size: 22),
                errorWidget: Image.asset(Assets.png_image.profile, height: 40),
                // errorWidget: SvgImage(image: Assets.svg.user_1, height: 28, color: primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            buddy.user?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyles.text15_500.copyWith(color: isUnread ? grey1 : grey2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        /*Text(
                          sl<Formatters>().formatTime(buddy.lastSendTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.text12_400.copyWith(color: grey3),
                        ),*/
                      ],
                    ),
                    const SizedBox(height: 01),
                    Text(
                      buddy.message ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.text14_400.copyWith(color: isUnread ? grey1 : grey3, fontWeight: isUnread ? w500 : w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
