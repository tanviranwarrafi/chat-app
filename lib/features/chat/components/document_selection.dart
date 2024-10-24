import 'package:app/models/system/data_model.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';

var _CAMERA = DataModel(label: 'Camera', icon: Assets.svg.camera, value: 'camera', valueInt: 0xFFF49B34);
var _GALLERY = DataModel(label: 'Gallery', icon: Assets.svg.image_square, value: 'gallery', valueInt: 0xFFF23333);

class DocumentSelection extends StatelessWidget {
  final bool isUploadType;
  final Function() onCamera;
  final Function() onGallery;

  const DocumentSelection({required this.isUploadType, required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(08);
    return AnimatedContainer(
      curve: Curves.easeIn,
      width: SizeConfig.width,
      height: isUploadType ? 64 : 0,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: offWhite2, borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
      child: !isUploadType
          ? const SizedBox.shrink()
          : Row(
              children: [
                Expanded(child: _MenuBox(item: _CAMERA, onTap: onCamera)),
                const SizedBox(width: 12),
                Expanded(child: _MenuBox(item: _GALLERY, onTap: onGallery))
              ],
            ),
    );
  }
}

class _MenuBox extends StatelessWidget {
  final DataModel item;
  final Function()? onTap;
  const _MenuBox({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 08),
        decoration: BoxDecoration(color: Color(item.valueInt), borderRadius: BorderRadius.circular(06)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(image: item.icon, height: 22, color: white),
            const SizedBox(width: 12),
            Expanded(child: Text(item.label, style: TextStyles.text14_500.copyWith(color: white, height: 1.2))),
          ],
        ),
      ),
    );
  }
}
