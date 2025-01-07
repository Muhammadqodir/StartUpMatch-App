part of 'createpost_cubit.dart';

abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  Post post;
  CreatePostSuccess({required this.post});
}

class CreatePostError extends CreatePostState {
  String title;
  String message;
  CreatePostError({
    required this.title,
    required this.message,
  });
}
