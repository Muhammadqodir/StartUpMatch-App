import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/chat/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void fetchChats() async {
    emit(ChatLoading());
    try {
      DataState<List<ChatModel>> chats =
          await (await getIt.getAsync<DataSource>()).fetchMyChats();
      if (chats.isSuccess) {
        emit(ChatSuccess(chats: chats.data!));
      } else {
        emit(ChatError(
          title: chats.title,
          message: chats.message,
        ));
      }
    } catch (e) {
      emit(ChatError(
        title: "Error",
        message: e.toString(),
      ));
    }
  }
}
