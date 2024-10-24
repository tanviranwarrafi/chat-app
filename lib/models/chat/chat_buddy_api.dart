import 'package:app/models/chat/chat_buddy.dart';

class ChatBuddyApi {
  bool? success;
  String? message;
  List<ChatBuddy>? buddies;

  ChatBuddyApi({this.success, this.message, this.buddies});

  ChatBuddyApi.fromJson(json) {
    success = json['success'];
    message = json['message'];
    buddies = [];
    if (json['data'] != null) json['data'].forEach((v) => buddies?.add(ChatBuddy.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (buddies != null) map['data'] = buddies?.map((v) => v.toJson()).toList();
    return map;
  }
}
