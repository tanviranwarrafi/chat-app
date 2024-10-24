import 'package:app/extensions/flutter_ext.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SheetHeader1 extends StatelessWidget {
  final String label;
  final Function()? onClose;

  const SheetHeader1({this.label = '', this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: white, borderRadius: SHEET_RADIUS, boxShadow: const [SHADOW_1]),
      child: Column(
        children: [
          const SizedBox(height: 06),
          Container(width: 105, height: 4, decoration: BoxDecoration(color: offWhite1, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: Text(label, style: TextStyles.text18_600.copyWith(color: grey1))),
              const SizedBox(width: 10),
              InkWell(onTap: onClose ?? backToPrevious, child: const Icon(Icons.close, color: grey2, size: 24)),
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
