import 'package:app/features/chat/chat_view_model.dart';
import 'package:app/features/chat_buddy/chat_buddy_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart' show SingleChildWidget;

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ChatBuddyViewModel()),
  ChangeNotifierProvider(create: (_) => ChatViewModel()),
];
