import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/chat/chat_message.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  void fetchMessages(int counterpartUserId) async {
    emit(MessageLoading());
    try {
      DataState<List<ChatMessage>> messages =
          await (await getIt.getAsync<DataSource>())
              .fetchMessages(counterpartUserId);
      if (messages.isSuccess) {
        emit(MessageSuccess(messages: messages.data!));
      } else {
        emit(MessageError(
          title: messages.title,
          message: messages.message,
        ));
      }
    } catch (e) {
      emit(MessageError(
        title: "Error",
        message: e.toString(),
      ));
    }
  }

  Future<void> sendMessage({
    required int cUserId,
    required String text,
    File? attachment,
  }) async {
    if (state is MessageSuccess) {
      emit(MessageSendingState(messages: (state as MessageSuccess).messages));
      DataState<List<ChatMessage>> messages =
          await (await getIt.getAsync<DataSource>()).sendMessage(
        cUserId: cUserId,
        text: text,
        attachment: attachment,
      );
      if (messages.isSuccess) {
        emit(MessageSuccess(messages: messages.data!));
      } else {
        emit(MessageError(
          title: messages.title,
          message: messages.message,
        ));
      }
    }
  }
}
