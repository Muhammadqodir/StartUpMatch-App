import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/user.dart';

class ChatModel {
  int id;
  User user;
  User user1;
  List<ChatMessage> lastMessages;
  ChatModel({
    required this.id,
    required this.user,
    required this.user1,
    required this.lastMessages,
  });

  User getCompanion(User me) {
    if (me.equal(user)) {
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
}
