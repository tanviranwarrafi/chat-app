import 'package:app/extensions/flutter_ext.dart';
import 'package:app/extensions/string_ext.dart';
import 'package:app/models/chat/chat_content.dart';

class ChatMessage {
  int? id;
  int? senderId;
  int? receiverId;
  String? type;
  String? message;
  String? sendTime;
  String? readTime;
  String? updatedAt;
  String? createdAt;
  List<ChatContent>? contents;
  String? chatStatus;
  int? sendTimeInMS;
  int dateMilliSecond = 00000;

  bool get chat_status => id != null && chatStatus != null && (chatStatus.toKey == 'sent'.toKey || chatStatus.toKey == 'received'.toKey);

  List<ChatContent> get chat_images {
    if (type == null || type != 'mixed' || !contents.haveList) return [];
    return contents!.where((item) => item.type != null && item.type!.split('/').first.toKey == 'image'.toKey).toList();
  }

  List<ChatContent> get chat_files {
    if (type == null || type != 'mixed' || !contents.haveList) return [];
    return contents!.where((item) => item.type != null && item.type!.split('/').first.toKey == 'application'.toKey).toList();
  }

  ChatMessage({
    this.id,
    this.senderId,
    this.receiverId,
    this.type,
    this.message,
    this.sendTime,
    this.readTime,
    this.updatedAt,
    this.createdAt,
    this.contents,
    this.chatStatus,
    this.sendTimeInMS,
    this.dateMilliSecond = 00000,
  });

  ChatMessage.fromJson(json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    type = json['type'];
    message = json['msg'];
    sendTime = json['send_t'];
    readTime = json['read_t'];
    // err = json['err'];
    // data = json['data'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    contents = [];
    if (json['contents'] != null) json['contents'].forEach((v) => contents?.add(ChatContent.fromJson(v)));
    chatStatus = json['direction'];
    sendTimeInMS = json['send_time_in_sec'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['type'] = type;
    map['msg'] = message;
    map['send_t'] = sendTime;
    map['read_t'] = readTime;
    // map['err'] = err;
    // map['data'] = data;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    if (contents != null) map['contents'] = contents?.map((v) => v.toJson()).toList();
    map['direction'] = chatStatus;
    map['send_time_in_sec'] = sendTimeInMS;
    return map;
  }
}
