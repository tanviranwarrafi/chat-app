import 'package:app/themes/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color color;
  final double radius;
  final BlendMode colorBlendMode;
  final FilterQuality filterQuality;
  final Widget? errorWidget;
  final Widget? placeholder;
  final Function()? onTap;

  const ImageNetwork({
    this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = transparent,
    this.colorBlendMode = BlendMode.darken,
    this.filterQuality = FilterQuality.high,
    this.placeholder,
    this.errorWidget,
    this.radius = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(radius);
    return ClipRRect(borderRadius: borderRadius, child: image == null ? _errorWidget() : _networkImage(context));
  }

  Widget _networkImage(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image!,
            width: width,
            height: height,
            fit: fit,
            colorBlendMode: colorBlendMode,
            filterQuality: filterQuality,
            placeholder: placeholder == null ? null : (context, url) => _placeholder(),
            errorWidget: errorWidget == null ? null : (context, url, error) => _errorWidget(),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius)),
          ),
        ],
      ),
      /*child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.darken),
        child: CachedNetworkImage(
          imageUrl: image!,
          width: width,
          height: height,
          fit: fit,
          // color: color,
          // colorBlendMode: colorBlendMode,
          filterQuality: filterQuality,
          placeholder: placeholder == null ? null : (context, url) => _placeholder(),
          errorWidget: errorWidget == null ? null : (context, url, error) => _errorWidget(),
        ),
      ),*/
    );
  }

  Widget _errorWidget() => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
        child: errorWidget ?? Container(),
      );
  Widget _placeholder() => Container(width: width, height: height, alignment: Alignment.center, child: placeholder ?? Container());
}
