import 'package:app/themes/colors.dart';
import 'package:flutter/cupertino.dart';

class ChatImageLoaderList extends StatelessWidget {
  final int length;
  const ChatImageLoaderList({required this.length});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76 + 20,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
        itemCount: length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: _imageLoaderItemCard,
        padding: const EdgeInsets.only(top: 12, bottom: 08),
      ),
    );
  }

  Widget _imageLoaderItemCard(BuildContext context, int index) {
    return Container(
      width: 110,
      height: 76,
      margin: EdgeInsets.only(right: index == length - 1 ? 0 : 08),
      decoration: BoxDecoration(color: offWhite1, borderRadius: BorderRadius.circular(06)),
      child: const Center(child: CupertinoActivityIndicator(color: primary, radius: 14)),
    );
  }
}
