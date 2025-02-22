part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  List<ChatModel> chats;
  ChatSuccess({required this.chats});
}

class ChatError extends ChatState {
  String title;
  String message;
  ChatError({
    required this.title,
    required this.message,
  });
}
