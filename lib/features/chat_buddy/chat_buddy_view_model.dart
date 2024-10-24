import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/chat/chat_message.dart';
import 'package:app/models/user/user.dart';
import 'package:app/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatBuddyViewModel with ChangeNotifier {
  var loader = false;
  var buddies = <ChatBuddy>[];

  void initViewModel() {
    /*if (!ApiStatus.common.chatBuddies) */
    fetchAllChatBuddies();
  }

  void disposeViewModel() {
    loader = false;
  }

  void clearStates() {
    loader = true;
    buddies.clear();
    // ApiStatus.common.chatBuddies = false;
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
    // if (response.haveList) buddies = response;
    loader = false;
    notifyListeners();
  }

  /* ----- Use For Other View Models ----- */

  void onChangeFavourite(ChatBuddy buddy, bool status) {
    var index = _getBuddyIndex(buddy);
    if (index >= 0) buddies[index].isFavourite = status;
    notifyListeners();
  }

  int _getBuddyIndex(ChatBuddy buddy) {
    if (!buddies.haveList) return -1;
    // var user = sl<StorageService>().user;
    /*if (user.is_agent_type) {
      return buddies.indexWhere((item) => item.user?.id.parseInt == buddy.user?.id.parseInt);
    } else {
      return buddies.indexWhere((item) => _checkBrokerageHouseId(item, buddy));
    }*/
    return -1;
  }

  /*bool _checkBrokerageHouseId(ChatBuddy listBuddy, ChatBuddy buddy) {
    var isUserId = listBuddy.user?.id?.parseInt == buddy.user?.id.parseInt;
    var isBrokerageHouseId = listBuddy.brokerageHouseId.parseInt == buddy.brokerageHouseId.parseInt;
    return isUserId && isBrokerageHouseId;
  }*/

  void onRemoveChatBuddy(ChatBuddy buddy) {
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    if (buddies[index].favourite == false) {
      buddies.removeAt(index);
    } else {
      buddies[index].message = 'No message';
      buddies[index].readT = '$currentDate';
    }
    notifyListeners();
  }

  void setLastMessage(ChatMessage message) {
    if (message.chatStatus == null) return;
    var id = message.chatStatus == 'sent' ? message.receiverId ?? 0 : message.senderId ?? 0;
    // var buddy = ChatBuddy(brokerageHouseId: message.brokerageHouseId ?? 0, user: AgentUser(id: id));
    var buddy = ChatBuddy(user: User(id: id));
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    if (message.message == null && message.contents.haveList) {
      buddies[index].message = message.message ?? 'Sent some files';
    } else {
      buddies[index].message = message.message ?? '';
    }
    buddies[index].sendT = message.sendTime;
    buddies[index].lastSendTime = message.sendTime;
    buddies[index].readT = message.sendTime;
    notifyListeners();
  }

  void setReceivedMessage(ChatMessage message) {
    // var buddy = ChatBuddy(brokerageHouseId: message.brokerageHouseId ?? 0, user: AgentUser(id: message.senderId ?? 0));
    var buddy = ChatBuddy(user: User(id: message.senderId ?? 0));
    var index = _getBuddyIndex(buddy);
    if (index < 0) return;
    if (message.message == null && message.contents.haveList) {
      buddies[index].message = message.message ?? 'Sent some files';
    } else {
      buddies[index].message = message.message ?? '';
    }
    buddies[index].sendT = message.sendTime;
    buddies[index].lastSendTime = message.sendTime;
    buddies[index].readT = message.readTime;
    notifyListeners();
  }
}
