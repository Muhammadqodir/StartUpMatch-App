part of 'my_posts_cubit.dart';

abstract class MyPostsState {}

class InitialMyPostsState extends MyPostsState {}

class LoadingMyPostsState extends MyPostsState {}

class ErrorMyPostsState extends MyPostsState {
  String title;
  String message;
  ErrorMyPostsState({
    required this.title,
    required this.message,
  });
}

class SuccessMyPostsState extends MyPostsState {
  List<Post> myPosts;

  SuccessMyPostsState({
    required this.myPosts,
  });
}
