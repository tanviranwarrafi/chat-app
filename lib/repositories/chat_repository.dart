import 'package:app/di.dart';
import 'package:app/features/chat_buddy/chat_buddy_view_model.dart';
import 'package:app/libraries/toasts_popups.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/chat/chat_content.dart';
import 'package:app/models/chat/chat_message.dart';
import 'package:app/models/system/api_response.dart';
import 'package:app/models/user/user.dart';
import 'package:app/utils/keys.dart';
import 'package:provider/provider.dart';

class ChatRepository {
  Future<List<ChatBuddy>> fetchChatBuddies() async {
    // var isAgent = sl<StorageService>().user.is_agent_type;
    // var agentId = sl<StorageService>().defaultAgent.id;
    // var endpoint = isAgent ? '${ApiUrl.agent.buddyList}$agentId' : ApiUrl.user.buddyList;
    // var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    await Future.delayed(const Duration(seconds: 1));
    var apiResponse = ApiResponse(status: 200, response: {});
    if (apiResponse.status == 200) {
      // var buddyApi = ChatBuddyApi.fromJson(apiResponse.response);
      // return buddyApi.buddies.haveList ? buddyApi.buddies! : [];
      return CHAT_BUDDIES;
    } else {
      return [];
    }
  }

  Future<List<ChatMessage>> fetchConversations({required ChatBuddy buddy, required int page}) async {
    // var isAgent = sl<StorageService>().user.is_agent_type;
    // var agentId = sl<StorageService>().defaultAgent.id;
    // var userEndpoint = '${ApiUrl.user.conversations}${buddy.id}&brokerage_house_id=${buddy.brokerageHouseId}&page=$page';
    // var agentEndpoint = '${ApiUrl.agent.conversations}${buddy.id}&brokerage_house_id=$agentId&page=$page';
    // var endpoint = isAgent ? agentEndpoint : userEndpoint;
    // var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    await Future.delayed(const Duration(seconds: 1));
    var apiResponse = ApiResponse(status: 200, response: {});
    if (apiResponse.status == 200) {
      // var conversation = ConversationApi.fromJson(apiResponse.response['data']);
      // if (!conversation.messages.haveList) return [];
      // var messageList = conversation.messages!.reversed.toList();
      // return messageList;
      // conversation.messages!.sort((item1, item2) => (item1.id ?? 0).compareTo(item2.id ?? 0));
      // conversation.messages!.forEach((item) => print(item.id));
      // return conversation.messages!;
      return [];
    } else {
      return [];
    }
  }

  Future<ChatMessage?> sendChatMessage(Map<String, String> body, List<ChatContent> contents, ChatMessage chat) async {
    // var isAgent = sl<StorageService>().user.is_agent_type;
    // var endpoint = isAgent ? ApiUrl.agent.sendMessage : ApiUrl.user.sendMessage;
    // http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    // request.fields.addAll(body);
    /*if (contents.haveList) {
      var files = contents.map((item) => item.doc!).toList();
      request.files.addAll(await sl<FileHelper>().getMultipartFiles('files[]', files));
    }*/
    // request.headers.addAll(await sl<HttpModule>().getMultipartHeaders);
    // var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    await Future.delayed(const Duration(seconds: 2));
    var apiResponse = ApiResponse(status: 200, response: {});
    if (apiResponse.status == 200) {
      // var chatMessage = ChatMessage.fromJson(apiResponse.response['data']);
      var chatMessage = chat;
      chatMessage.chatStatus = 'sent';
      chatMessage.dateMilliSecond = int.parse(body['time_millisecond']!);
      return chatMessage;
    } else {
      return null;
    }
  }

  Future<bool> deleteAllConversations(ChatBuddy buddy) async {
    // await Future.delayed(const Duration(seconds: 1));
    // return false;
    // var userEndpoint = '${ApiUrl.user.deleteAllConversations}${buddy.id}&brokerage_house_id=$houseId';
    // var agentEndpoint = '${ApiUrl.agent.deleteAllConversations}${buddy.id}&brokerage_house_id=$houseId';
    // var endpoint = isAgent ? agentEndpoint : userEndpoint;
    // var apiResponse = await sl<ApiInterceptor>().deleteRequest(endpoint: endpoint, header: Header.auth);
    await Future.delayed(const Duration(seconds: 1));
    var apiResponse = ApiResponse(status: 200, response: {});
    if (apiResponse.status != 200) return false;
    var context = navigatorKey.currentState?.context;
    if (context != null) Provider.of<ChatBuddyViewModel>(context, listen: false).onRemoveChatBuddy(buddy);
    sl<ToastPopup>().onToast(message: 'Conversations Deleted Successfully', isTop: true);
    return true;
  }
}

List<ChatBuddy> CHAT_BUDDIES = [
  ChatBuddy(
    id: 1,
    name: 'John Doe',
    brokerageHouseId: 101,
    lastSendTime: '2024-10-07 14:30',
    user: User(id: 1, name: 'johndoe', email: 'john@example.com'),
    message: 'Hey, how are you?',
    sendTimeInSec: 1633025456,
    isFavourite: true,
  ),
  ChatBuddy(
    id: 2,
    name: 'Jane Smith',
    brokerageHouseId: 102,
    lastSendTime: '2024-10-07 14:00',
    user: User(id: 2, name: 'janesmith', email: 'jane@example.com'),
    message: 'Meeting tomorrow at 10?',
    sendTimeInSec: 1633025087,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 3,
    name: 'David Brown',
    brokerageHouseId: 103,
    lastSendTime: '2024-10-07 12:15',
    user: User(id: 3, name: 'davidbrown', email: 'david@example.com'),
    message: 'Please review the report.',
    sendTimeInSec: 1633018052,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 4,
    name: 'Emily Clark',
    brokerageHouseId: 104,
    lastSendTime: '2024-10-07 11:45',
    user: User(id: 4, name: 'emilyclark', email: 'emily@example.com'),
    message: "I'll send the documents later.",
    sendTimeInSec: 1633015924,
    isFavourite: true,
  ),
  ChatBuddy(
    id: 1,
    name: 'John Doe',
    brokerageHouseId: 101,
    lastSendTime: '2024-10-07 14:30',
    user: User(id: 1, name: 'johndoe', email: 'john@example.com'),
    message: 'Hey, how are you?',
    sendTimeInSec: 1633025456,
    isFavourite: true,
  ),
  ChatBuddy(
    id: 2,
    name: 'Jane Smith',
    brokerageHouseId: 102,
    lastSendTime: '2024-10-07 14:00',
    user: User(id: 2, name: 'janesmith', email: 'jane@example.com'),
    message: 'Meeting tomorrow at 10?',
    sendTimeInSec: 1633025087,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 3,
    name: 'David Brown',
    brokerageHouseId: 103,
    lastSendTime: '2024-10-07 12:15',
    user: User(id: 3, name: 'davidbrown', email: 'david@example.com'),
    message: 'Please review the report.',
    sendTimeInSec: 1633018052,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 4,
    name: 'Emily Clark',
    brokerageHouseId: 104,
    lastSendTime: '2024-10-07 11:45',
    user: User(id: 4, name: 'emilyclark', email: 'emily@example.com'),
    message: "I'll send the documents later.",
    sendTimeInSec: 1633015924,
    isFavourite: true,
  ),
  ChatBuddy(
    id: 1,
    name: 'John Doe',
    brokerageHouseId: 101,
    lastSendTime: '2024-10-07 14:30',
    user: User(id: 1, name: 'johndoe', email: 'john@example.com'),
    message: 'Hey, how are you?',
    sendTimeInSec: 1633025456,
    isFavourite: true,
  ),
  ChatBuddy(
    id: 2,
    name: 'Jane Smith',
    brokerageHouseId: 102,
    lastSendTime: '2024-10-07 14:00',
    user: User(id: 2, name: 'janesmith', email: 'jane@example.com'),
    message: 'Meeting tomorrow at 10?',
    sendTimeInSec: 1633025087,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 3,
    name: 'David Brown',
    brokerageHouseId: 103,
    lastSendTime: '2024-10-07 12:15',
    user: User(id: 3, name: 'davidbrown', email: 'david@example.com'),
    message: 'Please review the report.',
    sendTimeInSec: 1633018052,
    isFavourite: false,
  ),
  ChatBuddy(
    id: 4,
    name: 'Emily Clark',
    brokerageHouseId: 104,
    lastSendTime: '2024-10-07 11:45',
    user: User(id: 4, name: 'emilyclark', email: 'emily@example.com'),
    message: "I'll send the documents later.",
    sendTimeInSec: 1633015924,
    isFavourite: true,
  ),
];
