import 'dart:async';

import 'package:app/constants/date_formats.dart';
import 'package:app/di.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/features/chat_buddy/chat_buddy_view_model.dart';
import 'package:app/helpers/file_helper.dart';
import 'package:app/libraries/formatters.dart';
import 'package:app/libraries/image_pickers.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/chat/chat_content.dart';
import 'package:app/models/chat/chat_message.dart';
import 'package:app/models/system/doc_file.dart';
import 'package:app/repositories/chat_repository.dart';
import 'package:app/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatViewModel with ChangeNotifier {
  var page = 1;
  var loader = true;
  var fileLoader = 0;
  var imageLoader = 0;
  var pageLoader = false;
  var isUploadType = false;
  var responseLength = 0;
  var chatMessage = TextEditingController();
  var scrollControl = ScrollController();
  var documents = <DocFile>[];
  var images = <DocFile>[];
  var messages = <ChatMessage>[];
  var sender = ChatBuddy();
  var receiver = ChatBuddy();

  void initViewModel(ChatBuddy buddy) {
    receiver = buddy;
    // var user = sl<StorageService>().user;
    // sender = user.is_agent_type ? sl<StorageService>().defaultAgent.buddy : user.buddy;
    notifyListeners();
    _fetchAllMessages();
    scrollControl.addListener(_onCheckPagination);
  }

  void disposeViewModel() {
    page = 1;
    responseLength = 0;
    pageLoader = false;
    documents.clear();
    images.clear();
    loader = true;
    imageLoader = 0;
    fileLoader = 0;
    isUploadType = false;
    messages.clear();
    chatMessage.clear();
    sender = ChatBuddy();
    receiver = ChatBuddy();
  }

  Future<void> _fetchAllMessages({bool isPaginate = false}) async {
    pageLoader = isPaginate;
    notifyListeners();
    var context = navigatorKey.currentState!.context;
    var response = await sl<ChatRepository>().fetchConversations(buddy: receiver, page: page);
    if (response.haveList) {
      messages.haveList ? messages.insertAll(0, response) : messages.addAll(response);
      responseLength = response.length;
      if (responseLength >= 20) page++;
      if (!isPaginate) Provider.of<ChatBuddyViewModel>(context, listen: false).setLastMessage(messages.last);
    }
    loader = false;
    pageLoader = false;
    notifyListeners();
    if (!isPaginate) unawaited(scrollDown());
  }

  void _onCheckPagination() {
    var maxPosition = scrollControl.position.pixels == scrollControl.position.minScrollExtent;
    if (maxPosition && responseLength >= 20) _fetchAllMessages(isPaginate: true);
  }

  Future<void> scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var duration = const Duration(milliseconds: 500);
    if (!scrollControl.hasClients) return;
    await scrollControl.animateTo(scrollControl.position.maxScrollExtent, duration: duration, curve: Curves.linear);
  }

  Future<void> imageFromCamera() async {
    var imageFile = await sl<ImagePickers>().imageFromCamera();
    if (imageFile == null) return;
    imageLoader = 1;
    notifyListeners();
    var modifiedImage = await sl<FileHelper>().renderFilesInModel([imageFile]);
    if (modifiedImage.haveList) images.insertAll(0, modifiedImage);
    isUploadType = false;
    imageLoader = 0;
    notifyListeners();
  }

  Future<void> imageFromGallery() async {
    var imageList = await sl<ImagePickers>().multiImageFromGallery(limit: 5);
    if (imageList.isEmpty) return;
    imageLoader = imageList.length;
    notifyListeners();
    var modifiedFiles = await sl<FileHelper>().renderFilesInModel(imageList);
    if (modifiedFiles.haveList) images.insertAll(0, modifiedFiles);
    isUploadType = false;
    imageLoader = 0;
    notifyListeners();
  }

  void removeFile(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  Future<void> onDeleteMessages() async {
    loader = true;
    notifyListeners();
    var response = await sl<ChatRepository>().deleteAllConversations(receiver);
    if (response) messages.clear();
    if (response) backToPrevious();
    loader = false;
    notifyListeners();
  }

  Future<void> addMessage() async {
    var context = navigatorKey.currentState!.context;
    var dateMillisecond = currentDate.millisecondsSinceEpoch;
    var contents = <ChatContent>[];
    if (images.haveList) images.forEach((v) => contents.add(ChatContent(doc: v, type: 'image/png', path: v.file?.path)));
    if (documents.haveList) documents.forEach((v) => contents.add(ChatContent(doc: v, type: 'application/pdf', path: v.file?.path)));
    var messageInfos = _newMessageInfo(dateMillisecond, contents);
    messages.add(messageInfos['message']);
    notifyListeners();
    chatMessage.clear();
    images.clear();
    documents.clear();
    unawaited(scrollDown());
    var response = await sl<ChatRepository>().sendChatMessage(messageInfos['body'], contents, messageInfos['message']);
    if (response != null) {
      var index = messages.indexWhere((item) => item.dateMilliSecond == response.dateMilliSecond);
      if (index >= 0) messages[index] = response;
      if (index >= 0) Provider.of<ChatBuddyViewModel>(context, listen: false).setLastMessage(messages.last);
      notifyListeners();
    } else {
      var index = messages.indexWhere((item) => item.dateMilliSecond == dateMillisecond);
      if (index >= 0) messages[index].chatStatus = 'error';
      notifyListeners();
    }
  }

  Map<String, dynamic> _newMessageInfo(int dateMS, List<ChatContent> contents) {
    Map<String, String> body = {
      'receiver_id': '${receiver.user?.id}',
      'type': contents.haveList ? 'mixed' : 'msg',
      'msg': chatMessage.text,
      'time_millisecond': '$dateMS'
    };
    var message = ChatMessage(
      id: messages.length,
      senderId: sender.user?.id,
      receiverId: receiver.user?.id,
      type: contents.haveList ? 'mixed' : 'msg',
      message: chatMessage.text,
      contents: contents,
      dateMilliSecond: dateMS,
      createdAt: sl<Formatters>().formatDate(DATE_FORMAT_4, '$currentDate'),
      sendTime: sl<Formatters>().formatDate(DATE_FORMAT_4, '$currentDate'),
    );
    return {'body': body, 'message': message};
  }

  /* ----- Use For Other ViewModels ----- */

  void setReceivedMessage(ChatMessage message) {
    if (sender.user?.id == null || receiver.user?.id == null) return;
    if ((message.senderId ?? 0) != (receiver.user?.id ?? 0)) return;
    messages.add(message);
    notifyListeners();
    unawaited(scrollDown());
  }
}
