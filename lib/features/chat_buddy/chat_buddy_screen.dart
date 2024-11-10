import 'package:app/components/loaders/screen_loader.dart';
import 'package:app/components/menus/prefix_menu.dart';
import 'package:app/components/menus/suffux_menu.dart';
import 'package:app/extensions/flutter_ext.dart';
import 'package:app/extensions/string_ext.dart';
import 'package:app/features/chat_buddy/chat_buddy_view_model.dart';
import 'package:app/features/chat_buddy/components/nearby_service_list.dart';
import 'package:app/features/chat_buddy/components/recent_messages_list.dart';
import 'package:app/themes/colors.dart';
import 'package:app/themes/text_styles.dart';
import 'package:app/utils/assets.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/core/input_field.dart';
import 'package:app/widgets/exception/no_conversation.dart';
import 'package:app/widgets/ui/appbar_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBuddyScreen extends StatefulWidget {
  @override
  State<ChatBuddyScreen> createState() => _ChatBuddyScreenState();
}

class _ChatBuddyScreenState extends State<ChatBuddyScreen> {
  var _focusNode = FocusNode();
  var _viewModel = ChatBuddyViewModel();
  var _modelData = ChatBuddyViewModel();
  var _search = TextEditingController();

  @override
  void initState() {
    _focusNode.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = Provider.of<ChatBuddyViewModel>(context, listen: false);
    _modelData = Provider.of<ChatBuddyViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        padding: EdgeInsets.only(top: SizeConfig.statusBar),
        child: _modelData.loader ? const ScreenLoader() : _screenView(context),
      ),
    );
  }

  Widget _screenView(BuildContext context) {
    var isFocus = _focusNode.hasFocus;
    var chatBuddies = _modelData.buddies;
    var isClose = _search.text.toKey.length > 0;
    // var chatBuddies = sl<FilterHelper>().buddiesByName(_search.text, _modelData.buddies);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        AppbarHeader(),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.screen_padding),
                child: Text('Chat with Your Providers', style: TextStyles.text24_600.copyWith(color: dark)),
              ),
              const SizedBox(height: 12),
              InputField(
                padding: 20,
                controller: _search,
                focusNode: _focusNode,
                onChanged: (v) => setState(() {}),
                hintText: 'Search by provider name',
                prefixIcon: PrefixMenu(icon: Assets.svg.search, isFocus: _focusNode.hasFocus),
                suffixIcon: !isClose ? null : SuffixMenu(icon: Assets.svg.close, isFocus: isFocus, onTap: () => setState(_search.clear)),
              ),
              const SizedBox(height: 24),
              NearbyServiceList(buddyList: chatBuddies),
              const SizedBox(height: 20),
              if (chatBuddies.haveList)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.screen_padding),
                  child: Text('Recent Messages', style: TextStyles.text18_600.copyWith(color: dark)),
                ),
              !chatBuddies.haveList ? const NoConversation() : RecentMessagesList(buddies: chatBuddies),
              const SizedBox(height: 08),
            ],
          ),
        ),
      ],
    );
  }
}
