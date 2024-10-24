import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:app/themes/shadows.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:flutter/material.dart';

class ChatAppointmentInfo extends StatelessWidget {
  final bool isLast;
  final bool isList;
  final String appointment;
  const ChatAppointmentInfo({required this.appointment, this.isLast = true, this.isList = false});

  @override
  Widget build(BuildContext context) {
    var isCancelled = isList && isLast;
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
      decoration: BoxDecoration(
        color: white,
        boxShadow: isList ? null : const [SHADOW_3],
        border: Border.all(color: offWhite1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const SizedBox(height: 08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 14),
              const Spacer(),
              Text('Mon, 24 Feb', style: TextStyles.text16_600.copyWith(color: grey1, height: 1)),
              const SizedBox(width: 8),
              Container(height: 18, width: 1, color: grey1),
              const SizedBox(width: 8),
              Text('08:00-09:00 am', style: TextStyles.text16_600.copyWith(color: grey1, height: 1)),
              const Spacer(),
              const SizedBox(width: 14),
            ],
          ),
          const SizedBox(height: 08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 14),
              const Spacer(),
              CircleImage(
                radius: 09,
                placeholder: Image.asset(Assets.png_image.profile, height: 18),
                errorWidget: Image.asset(Assets.png_image.profile, height: 18),
              ),
              const SizedBox(width: 8),
              Text('Nicolas Cage', style: TextStyles.text14_500.copyWith(color: grey1)),
              const Spacer(),
              const SizedBox(width: 14),
            ],
          ),
          if (isCancelled)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(color: offWhite2, borderRadius: BorderRadius.circular(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Message from Provider:', style: TextStyles.text12_500.copyWith(color: grey2, height: 1.2)),
                  const SizedBox(height: 2),
                  Text(
                    'We are extremely sorry to inform you that our resource is on vacation. Please book again with another resource.',
                    textAlign: TextAlign.start,
                    style: TextStyles.text14_400.copyWith(color: dark),
                  ),
                ],
              ),
            ),
          SizedBox(height: isCancelled ? 10 : 16),
          InkWell(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: offWhite1))),
              child: Text(
                isCancelled ? 'Book Again' : 'See Details',
                textAlign: TextAlign.center,
                style: TextStyles.text14_500.copyWith(color: isCancelled ? primary : grey2, fontWeight: w700, height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
