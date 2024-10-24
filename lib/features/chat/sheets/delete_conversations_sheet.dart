import 'package:app/components/buttons/elevate_button.dart';
import 'package:app/components/buttons/outline_button.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/utils/keys.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/core/pop_scope_navigator.dart';
import 'package:flutter/material.dart';

Future<void> deleteConversationsSheet({required Function() onDelete}) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    shape: BOTTOM_SHEET_SHAPE,
    clipBehavior: Clip.antiAlias,
    builder: (builder) => PopScopeNavigator(canPop: false, child: _BottomSheetView(onDelete)),
  );
}

class _BottomSheetView extends StatelessWidget {
  final Function() onDelete;
  const _BottomSheetView(this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width,
      child: _screenView(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: white, borderRadius: SHEET_RADIUS, boxShadow: const [SHADOW_3]),
    );
  }

  Widget _screenView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 06),
        Container(width: 105, height: 4, decoration: BoxDecoration(color: offWhite1, borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 32),
        Image.asset(Assets.png_image.bin_orange, height: 120),
        const SizedBox(height: 32),
        Text('Delete Conversation?', textAlign: TextAlign.center, style: TextStyles.text24_600.copyWith(color: error)),
        const SizedBox(height: 10),
        Text(
          'Once deleted, you will lose all your chat history in this conversation. Are you sure you want to delete this conversation?',
          textAlign: TextAlign.center,
          style: TextStyles.text16_400.copyWith(color: grey1),
        ),
        const SizedBox(height: 40),
        OutlineButton(color: error, label: 'Yes, Delete', width: double.infinity, onTap: _onDelete),
        const SizedBox(height: 12),
        ElevateButton(width: double.infinity, label: 'No, Keep', onTap: backToPrevious),
        SizedBox(height: BOTTOM_GAP),
      ],
    );
  }

  void _onDelete() {
    backToPrevious();
    onDelete();
  }
}
