import 'package:app/animations/tween_list_item.dart';
import 'package:app/components/loaders/fading_circle.dart';
import 'package:app/helpers/enums.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:flutter/material.dart';

class NearbyServiceList extends StatelessWidget {
  final List<ChatBuddy> buddyList;
  final Function(String)? onTap;
  const NearbyServiceList({this.buddyList = const [], this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.builder(
        shrinkWrap: true,
        clipBehavior: Clip.antiAlias,
        itemCount: buddyList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: _serviceItemCard,
      ),
    );
  }

  Widget _serviceItemCard(BuildContext context, int index) {
    var buddy = buddyList[index];
    var border = Border.all(strokeAlign: BorderSide.strokeAlignOutside, color: white);
    return TweenListItem(
      index: index,
      twinAnim: TwinAnim.right_to_left,
      child: Container(
        width: 80,
        key: Key('$index'),
        margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: index == buddyList.length - 1 ? 20 : 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleImage(
                  radius: 24,
                  borderWidth: 0.5,
                  borderColor: grey3,
                  backgroundColor: transparent,
                  placeholder: const FadingCircle(size: 14),
                  errorWidget: Image.asset(Assets.png_image.profile, height: 48),
                ),
                Positioned(
                  top: 0,
                  right: -14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 04, vertical: 04),
                    decoration: BoxDecoration(color: primary, border: border, borderRadius: BorderRadius.circular(03)),
                    child: Text('05/10', style: TextStyles.text10_700.copyWith(color: white, height: 1)),
                  ),
                ),
              ],
            ),
            Text(
              buddy.user?.name ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.text14_400.copyWith(color: grey1),
            ),
          ],
        ),
      ),
    );
  }
}
