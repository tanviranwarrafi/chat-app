import 'package:app/features/chat/chat_screen.dart';
import 'package:app/features/chat_buddy/chat_buddy_screen.dart';
import 'package:app/models/chat/chat_buddy.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static Widget chat_buddies() => ChatBuddyScreen();
  static Widget chat({required ChatBuddy buddy}) => ChatScreen(buddy: buddy);
}
