import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/data/remote/remote_data_source.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';

part 'createpost_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInitial());

  Future<void> createPitch({
    required String title,
    required String description,
    required File video,
  }) async {
    emit(CreatePostLoading());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    if (dataSource is RemoteDataSource) {
      DataState<PitchModel> response = await dataSource.createPitch(
        title: title,
        description: description,
        video: video,
      );
      if (response.isSuccess) {
        emit(CreatePostSuccess(post: response.data!));
      } else {
        emit(CreatePostError(title: response.title, message: response.message));
      }
    }
  }

  
}
