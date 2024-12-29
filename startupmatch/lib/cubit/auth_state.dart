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
  AuthorizedState({
    required this.user,
  });
}
