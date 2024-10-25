import 'dart:async';

import 'package:app/components/loaders/circle_loader.dart';
import 'package:app/components/loaders/screen_loader.dart';
import 'package:app/components/menus/prefix_menu.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/features/chat/chat_view_model.dart';
import 'package:app/features/chat/components/chat_app_bar.dart';
import 'package:app/features/chat/components/chat_image_loader.dart';
import 'package:app/features/chat/components/chat_images_list.dart';
import 'package:app/features/chat/components/chat_suggestions_list.dart';
import 'package:app/features/chat/components/chat_user_info.dart';
import 'package:app/features/chat/components/document_selection.dart';
import 'package:app/features/chat/components/messages_list.dart';
import 'package:app/features/chat/sheets/chat_menus_sheet.dart';
import 'package:app/features/chat/sheets/delete_conversations_sheet.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:app/models/system/data_model.dart';
import 'package:app/themes/colors.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/core/input_field.dart';
import 'package:app/widgets/library/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatBuddy buddy;
  const ChatScreen({required this.buddy});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _focusNode = FocusNode();
  var _viewModel = ChatViewModel();
  var _modelData = ChatViewModel();

  @override
  void initState() {
    _focusNode.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _viewModel.initViewModel(widget.buddy));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = Provider.of<ChatViewModel>(context, listen: false);
    _modelData = Provider.of<ChatViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        padding: EdgeInsets.only(top: SizeConfig.statusBar, left: 20, right: 20),
        child: Stack(children: [_screenView(context), if (_modelData.loader) const ScreenLoader()]),
      ),
    );
  }

  void _onOption() => chatMenusSheet(buddy: widget.buddy, onDelete: () => deleteConversationsSheet(onDelete: _viewModel.onDeleteMessages));

  Widget _screenView(BuildContext context) {
    // var user = sl<StorageService>().user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: !_modelData.messages.haveList ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
        ChatAppBar(buddy: widget.buddy, onMoreVert: _onOption),
        const SizedBox(height: 16),
        Expanded(
          child: Stack(
            alignment: !_modelData.messages.haveList ? Alignment.topCenter : Alignment.bottomCenter,
            clipBehavior: Clip.antiAlias,
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                controller: _viewModel.scrollControl,
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 60),
                  ChatUserInfo(buddy: widget.buddy),
                  const SizedBox(height: 24),
                  if (_modelData.pageLoader) const Padding(padding: EdgeInsets.only(bottom: 24), child: CircleLoader()),
                  if (_modelData.messages.isNotEmpty) MessagesList(messages: _modelData.messages, sender: _modelData.sender),
                  if (_modelData.images.haveList) const SizedBox(height: 76 + 20),
                  if (_modelData.documents.haveList) const SizedBox(height: 52 + 20),
                  SizedBox(height: (_modelData.messages.isNotEmpty ? 48 : 90) + BOTTOM_GAP),
                ],
              ),
              Positioned(left: 0, right: 0, bottom: BOTTOM_GAP, child: _chatInputArea(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatInputArea(BuildContext context) {
    var iLoad = _modelData.imageLoader;
    var uploadType = _modelData.isUploadType;
    var radius = const Radius.circular(08);
    var top = uploadType ? Radius.zero : radius;
    var borderRadius = BorderRadius.only(topLeft: top, topRight: top, bottomLeft: radius, bottomRight: radius);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_modelData.messages.isEmpty) ChatSuggestionsList(suggestions: CHAT_SUGGESTIONS, onTap: _onSuggestion),
        SizedBox(height: _modelData.images.isEmpty ? 12 : 0),
        iLoad > 0 ? ChatImageLoaderList(length: iLoad) : ChatImagesList(images: _modelData.images, onTap: _viewModel.removeImage),
        DocumentSelection(isUploadType: uploadType, onCamera: _viewModel.imageFromCamera, onGallery: _viewModel.imageFromGallery),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: uploadType ? 02 : 0),
          decoration: BoxDecoration(color: offWhite2, borderRadius: borderRadius),
          child: InputField(
            maxLines: 6,
            focusNode: _focusNode,
            hintText: 'Type your message',
            controller: _modelData.chatMessage,
            onChanged: (val) => setState(() {}),
            onTap: _onTapInputField,
            suffixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 08), child: _sendButton),
            prefixIcon: PrefixMenu(icon: Assets.svg.paper_clip, isFocus: _focusNode.hasFocus, onTap: _onPrefix),
          ),
        ),
      ],
    );
  }

  void _onSuggestion(DataModel item) => setState(() => _viewModel.chatMessage.text = item.label);

  Future<void> _onTapInputField() async {
    await Future.delayed(const Duration(milliseconds: 400));
    unawaited(_viewModel.scrollDown());
  }

  void _onPrefix() => setState(() => _modelData.isUploadType = !_modelData.isUploadType);

  Widget? get _sendButton {
    var isShow = _modelData.chatMessage.text.isEmpty && _modelData.images.isEmpty && _modelData.documents.isEmpty;
    if (isShow) return null;
    var icon = SvgImage(image: Assets.svg.paper_plane_right, color: white, height: 20);
    return InkWell(onTap: _viewModel.addMessage, child: CircleAvatar(radius: 18, backgroundColor: primary, child: icon));
  }
}
