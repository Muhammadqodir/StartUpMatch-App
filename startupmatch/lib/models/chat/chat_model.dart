// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/user.dart';

class ChatModel {
  User user;
  User user1;
  List<ChatMessage> lastMessages;
  ChatModel({
    required this.user,
    required this.user1,
    required this.lastMessages,
  });

  User getCompanion(User me) {
    if (!me.equal(user)) {
      return user;
    }
    return user1;
  }

  ChatMessage? getLastMessage() {
    if (lastMessages.isNotEmpty) {
      return lastMessages[0];
    } else {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'user1': user1.toMap(),
      'lastMessages': lastMessages.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      user: User.fromMap(map['user'] as Map<String,dynamic>),
      user1: User.fromMap(map['user1'] as Map<String,dynamic>),
      lastMessages: List<ChatMessage>.from((map['lastMessages'] as List<dynamic>).map<ChatMessage>((x) => ChatMessage.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
