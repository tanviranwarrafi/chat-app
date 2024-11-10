import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/chat/chat_message.dart';
import 'package:app/models/user/user.dart';
import 'package:app/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatBuddyViewModel with ChangeNotifier {
  var loader = true;
  var buddies = <ChatBuddy>[];

  void initViewModel() {
    fetchAllChatBuddies();
  }

  void disposeViewModel() {
    loader = false;
  }

  void clearStates() {
    loader = true;
    buddies.clear();
  }

  Future<void> fetchAllFavouriteBuddies() async {
    var response = await sl<ChatRepository>().fetchChatBuddies();
    if (response.haveList) buddies = response;
    loader = false;
    notifyListeners();
  }

  Future<void> fetchAllChatBuddies() async {
    var response = await sl<ChatRepository>().fetchChatBuddies();
    if (kDebugMode) print(response);
    buddies = CHAT_BUDDIES;
    loader = false;
    notifyListeners();
  }

  /* ----- Use For Other View Models ----- */

  int _getBuddyIndex(ChatBuddy buddy) {
    if (!buddies.haveList) return -1;
    return -1;
  }

  void onRemoveChatBuddy(ChatBuddy buddy) {
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    notifyListeners();
  }

  void setLastMessage(ChatMessage message) {
    if (message.chatStatus == null) return;
    var id = message.chatStatus == 'sent' ? message.receiverId ?? 0 : message.senderId ?? 0;
    var buddy = ChatBuddy(user: User(id: id));
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    if (message.message == null && message.contents.haveList) {
      buddies[index].message = message.message ?? 'Sent some files';
    } else {
      buddies[index].message = message.message ?? '';
    }
    notifyListeners();
  }

  void setReceivedMessage(ChatMessage message) {
    var buddy = ChatBuddy(user: User(id: message.senderId ?? 0));
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    if (message.message == null && message.contents.haveList) {
      buddies[index].message = message.message ?? 'Sent some files';
    } else {
      buddies[index].message = message.message ?? '';
    }
    notifyListeners();
  }
}
