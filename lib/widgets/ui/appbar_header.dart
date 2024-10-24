import 'package:app/components/loaders/fading_circle.dart';
import 'package:app/libraries/fake_data.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:app/widgets/ui/circle_icon_box.dart';
import 'package:flutter/material.dart';

class AppbarHeader extends StatelessWidget {
  /*final int listLength;
  final Function() onRefresh;
  WelcomeHeader({required this.listLength, required this.onRefresh});*/

  @override
  Widget build(BuildContext context) {
    var isCustomer = false;
    return Row(
      children: [
        const SizedBox(width: 20),
        InkWell(
          // onTap: () => Provider.of<LandingViewModel>(context, listen: false).updateView(3),
          child: CircleImage(
            borderColor: dark,
            borderWidth: 1,
            placeholder: const FadingCircle(size: 20),
            errorWidget: Image.asset(Assets.png_image.profile, height: 40, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              // onTap: () => Provider.of<LandingViewModel>(context, listen: false).updateView(3),
              child: Text(
                'Sergei Kraven',
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyles.text15_500.copyWith(color: grey1),
              ),
            ),
            Text(
              isCustomer ? 'Add Location' : FakeData.address,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyles.text14_500.copyWith(color: isCustomer ? primary : grey2),
            )
          ],
        )),
        const SizedBox(width: 08),
        CircleIconBox(
          size: 36,
          background: offWhite2,
          icon: SvgImage(image: Assets.svg.bell, height: 22, color: grey1),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
