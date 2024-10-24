import 'package:app/components/headers/sheet_header_1.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/utils/keys.dart';
import 'package:app/widgets/core/pop_scope_navigator.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

Future<void> chatMenusSheet({required ChatBuddy buddy, required Function()? onDelete}) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    shape: BOTTOM_SHEET_SHAPE,
    clipBehavior: Clip.antiAlias,
    builder: (builder) => PopScopeNavigator(canPop: false, child: _BottomSheetView(buddy, onDelete)),
  );
}

class _BottomSheetView extends StatelessWidget {
  final ChatBuddy buddy;
  final Function()? onDelete;
  const _BottomSheetView(this.buddy, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: _screenView(context),
      decoration: BoxDecoration(color: white, borderRadius: SHEET_RADIUS, boxShadow: const [SHADOW_3]),
    );
  }

  Widget _screenView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHeader1(label: 'More Options'),
        const SizedBox(height: 06),
        ListView(
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            _OptionItem(icon: Assets.svg.info_1, label: 'View Profile'),
            const Divider(color: offWhite1),
            _OptionItem(icon: Assets.svg.calendar_blank_1, label: 'Book Appointment'),
            const Divider(color: offWhite1),
            _OptionItem(icon: Assets.svg.calendar_check_1, label: 'Current Appointment', count: 05),
            const Divider(color: offWhite1),
            _OptionItem(icon: Assets.svg.list_check, label: 'All Appointment'),
            const Divider(color: offWhite1),
            _OptionItem(icon: Assets.svg.phone, label: 'Contact Info'),
            const Divider(color: offWhite1),
            _OptionItem(icon: Assets.svg.trash, label: 'Delete Conversation', color: error, onTap: () => _onTap(onTap: onDelete)),
          ],
        ),
        SizedBox(height: BOTTOM_GAP),
      ],
    );
  }

  void _onTap({Function()? onTap}) {
    backToPrevious();
    if (onTap != null) onTap();
  }
}

class _OptionItem extends StatelessWidget {
  final int count;
  final Color color;
  final String icon;
  final String label;
  final Function()? onTap;
  const _OptionItem({this.icon = '', this.label = '', this.color = grey1, this.onTap, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            if (icon.isNotEmpty) SvgImage(image: icon, height: 24, color: color),
            if (icon.isNotEmpty) const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.text16_400.copyWith(color: color),
              ),
            ),
            if (count > 0)
              Container(
                margin: const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 04),
                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(6)),
                child: Text('$count', style: TextStyles.text14_500.copyWith(color: white, height: 1.1)),
              ),
          ],
        ),
      ),
    );
  }
}
