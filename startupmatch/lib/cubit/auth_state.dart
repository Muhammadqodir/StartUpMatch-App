// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class UnAuthorizedState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  String title;
  String message;
  ErrorAuthState({
    required this.title,
    required this.message,
  });
}

class AuthorizedState extends AuthState {
  User user;
  List<Post> myPosts;

  AuthorizedState({
    required this.user,
    this.myPosts = const [],
  });

  AuthorizedState copyWith({
    User? user,
    List<Post>? myPosts,
  }) {
    return AuthorizedState(
      user: user ?? this.user,
      myPosts: myPosts ?? this.myPosts,
    );
  }
}
