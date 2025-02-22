part of 'message_cubit.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageSendingState extends MessageSuccess {
  MessageSendingState({required super.messages});
}

class MessageSuccess extends MessageState {
  List<ChatMessage> messages;
  MessageSuccess({required this.messages});
}

class MessageError extends MessageState {
  String title;
  String message;
  MessageError({
    required this.title,
    required this.message,
  });
}
