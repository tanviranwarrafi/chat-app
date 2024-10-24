import 'package:app/constants/date_formats.dart';
import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/extensions/number_ext.dart';
import 'package:app/extensions/string_ext.dart';
import 'package:app/libraries/formatters.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/chat/chat_content.dart';
import 'package:app/models/chat/chat_message.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/fonts.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/widgets/core/memory_image.dart';
import 'package:app/widgets/library/image_network.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  final ChatBuddy sender;
  final List<ChatMessage> messages;
  final ScrollPhysics physics;

  const MessagesList({required this.sender, this.messages = const [], this.physics = const NeverScrollableScrollPhysics()});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      itemCount: messages.length,
      itemBuilder: _messageItemCard,
      physics: physics,
    );
  }

  bool _isDateMessage(int index) {
    var message = messages[index];
    if (message.createdAt == null) return false;
    if (index == 0) return true;
    var previousMessage = messages[index - 1];
    if (previousMessage.createdAt == null) return false;
    return !DateUtils.isSameDay(message.createdAt!.parseDate, previousMessage.createdAt!.parseDate);
  }

  String _messageDate(String date) {
    var difference = currentDate.difference(date.parseDate).inDays;
    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Yesterday';
      case 2:
        return sl<Formatters>().formatDate(DATE_FORMAT_1, date);
      case 3:
        return sl<Formatters>().formatDate(DATE_FORMAT_1, date);
      case 4:
        return sl<Formatters>().formatDate(DATE_FORMAT_1, date);
      case 5:
        return sl<Formatters>().formatDate(DATE_FORMAT_1, date);
      case 6:
        return sl<Formatters>().formatDate(DATE_FORMAT_1, date);
      default:
        return sl<Formatters>().formatDate(DATE_FORMAT_14, date);
    }
  }

  bool _isSameUser(int? userId1, int? userId2) => userId1 == null || userId2 == null ? true : userId1 == userId2;

  bool _isShowTime(int index) {
    var message = messages[index];
    if (message.createdAt == null) return false;
    if (index == messages.length - 1) return true;
    return !_isSameUser(message.senderId, messages[index + 1].senderId);
  }

  Widget _messageItemCard(BuildContext context, int index) {
    var chat = messages[index];
    var isMe = chat.senderId == sender.id;
    var isDateMessage = _isDateMessage(index);
    var isShowTime = _isShowTime(index);
    var time = sl<Formatters>().formatTime('${chat.createdAt}');
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: index == messages.length - 1 ? 20 : (!isShowTime ? 6 : 16)),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (index != 0 && isDateMessage) const SizedBox(height: 10),
          if (isDateMessage) _messageDateInfo(chat),
          if (isDateMessage) const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _boxDecoration(index, isMe),
            constraints: BoxConstraints(minWidth: 20, maxWidth: 70.width),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [_messageImageList(chat), _chatMessage(chat.message, isMe)],
            ),
          ),
          if (!chat.chat_status) Text('Sending...', style: TextStyles.text10_700.copyWith(color: grey2).copyWith(fontWeight: w400)),
          if (chat.chat_status && isShowTime) const SizedBox(height: 2),
          if (chat.chat_status && isShowTime) Text(time, style: TextStyles.text10_700.copyWith(color: grey2, fontWeight: w400)),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(int index, bool isMe) {
    var radius = const Radius.circular(10);
    var isNextSame = index != messages.length - 1 && _isSameUser(messages[index].id, messages[index + 1].id);
    var left = isMe || (!isMe && isNextSame) ? radius : Radius.zero;
    var right = !isMe || (isMe && isNextSame) ? radius : Radius.zero;
    var borderRadius = BorderRadius.only(topLeft: radius, topRight: radius, bottomLeft: left, bottomRight: right);
    return BoxDecoration(color: isMe ? primary : offWhite2, borderRadius: borderRadius);
  }

  Widget _messageDateInfo(ChatMessage message) {
    return Row(
      children: [
        const Expanded(child: Divider(color: offWhite2)),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: offWhite2, borderRadius: BorderRadius.circular(16)),
          child: Text(_messageDate(message.createdAt!), style: TextStyles.text12_400.copyWith(color: grey2)),
        ),
        const Expanded(child: Divider(color: offWhite2)),
      ],
    );
  }

  Widget _chatMessage(String? message, bool isMe) {
    if (message.toKey.isEmpty) return const SizedBox.shrink();
    // var align = isMe ? TextAlign.left : TextAlign.left;
    return Text(message!, textAlign: TextAlign.left, style: TextStyles.text14_400.copyWith(color: isMe ? white : dark, height: 1));
  }

  Widget _messageImageList(ChatMessage chat) {
    var imageList = chat.chat_images;
    if (imageList.isEmpty) return const SizedBox.shrink();
    var padding = EdgeInsets.only(bottom: chat.message.toKey.isEmpty ? 0 : 08);
    if (imageList.length == 1) return Padding(padding: padding, child: _imageItemCard(imageList.first, chat.chat_status, true));
    return GridView.builder(
      padding: padding,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      itemCount: imageList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _imageItemCard(imageList[index], chat.chat_status, false),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 6, mainAxisSpacing: 6, childAspectRatio: 1.5),
    );
  }

  Widget _imageItemCard(ChatContent image, bool isSent, bool isSingle) {
    return isSent
        ? ImageNetwork(
            radius: 6,
            width: double.infinity,
            // height: 100,
            image: image.path,
            color: primary.withOpacity(0.1),
            // placeholder: ErrorImage(size: const Size(double.infinity, 100), imageSize: isSingle ? 60 : 40),
            // errorWidget: ErrorImage(size: const Size(double.infinity, 100), imageSize: isSingle ? 60 : 40),
          )
        : ImageMemory(
            radius: 06,
            // height: 100,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            colorBlendMode: BlendMode.darken,
            image: image.doc?.unit8List,
            width: double.infinity,
            // error: ErrorImage(size: const Size(double.infinity, 100), imageSize: isSingle ? 60 : 40),
          );
  }
}
