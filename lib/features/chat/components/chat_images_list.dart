import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/system/doc_file.dart';
import 'package:app/themes/colors.dart';
import 'package:app/utils/assets.dart';
import 'package:app/widgets/core/memory_image.dart';
import 'package:app/widgets/library/circle_image.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatImagesList extends StatelessWidget {
  final List<DocFile> images;
  final Function(int) onTap;

  const ChatImagesList({required this.images, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (!images.haveList) return const SizedBox.shrink();
    return Container(
      height: 76 + 20,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
        itemCount: images.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: _imageItemCard,
        padding: const EdgeInsets.only(top: 12, bottom: 08),
      ),
    );
  }

  Widget _imageItemCard(BuildContext context, int index) {
    var image = images[index];
    var closeIcon = SvgImage(image: Assets.svg.close, color: dark, height: 15);
    return Container(
      width: 110,
      height: 76,
      margin: EdgeInsets.only(right: index == images.length - 1 ? 0 : 08),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(06)),
      child: Stack(
        children: [
          ImageMemory(
            width: 110,
            height: 76,
            radius: 06,
            fit: BoxFit.cover,
            color: dark.withOpacity(0.1),
            filterQuality: FilterQuality.high,
            colorBlendMode: BlendMode.darken,
            image: image.unit8List,
            // error: ErrorUserImage3(size: 80, imageSize: 48, background: offWhite2),
          ),
          Positioned(top: 4, right: 4, child: CircleImage(radius: 10, errorWidget: closeIcon, onTap: () => onTap(index))),
        ],
      ),
    );
  }
}
