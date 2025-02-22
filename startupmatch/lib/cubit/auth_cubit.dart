import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/data/local/local_data_source.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  Future<void> checkAuth() async {
    emit(LoadingAuthState());
    if (await getIt<LocalDataSource>().isLogin()) {
      try {
        final getIt = GetIt.instance;
        await getIt.reset();
        await setupDependencies();
        await getIt.allReady();
        emit(
          AuthorizedState(
            user: (await getIt<LocalDataSource>().getUser())!,
          ),
        );
      } catch (e, s) {
        emit(ErrorAuthState(title: e.toString(), message: s.toString()));
      }
    } else {
      emit(UnAuthorizedState());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoadingAuthState());

    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.login(
      email: email,
      password: password,
    );
    if (response.isSuccess) {
      getIt<LocalDataSource>().saveData("user", response.data!.toJson());
      getIt<LocalDataSource>().saveData("token", response.data!.token);
      getIt<LocalDataSource>().setIsLogin(true);
      emit(AuthorizedState(user: response.data!));
    } else {
      emit(ErrorAuthState(title: response.title, message: response.message));
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String userType,
  }) async {
    emit(LoadingAuthState());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.register(
      email: email,
      password: password,
      fullName: fullName,
      userType: userType,
    );
    if (response.isSuccess) {
      getIt<LocalDataSource>().saveData("user", response.data!.toJson());
      getIt<LocalDataSource>().saveData("token", response.data!.token);
      getIt<LocalDataSource>().setIsLogin(true);
      emit(AuthorizedState(user: response.data!));
    } else {
      emit(ErrorAuthState(title: response.title, message: response.message));
    }
  }

  Future<void> getMe() async {
    if (state is AuthorizedState) {
      DataSource dataSource = await getIt.getAsync<DataSource>();
      DataState<User> me = await dataSource.getMe();
      if (me.isSuccess) {
        emit((state as AuthorizedState).copyWith(user: me.data!));
      }
    }
  }

  Future<void> updateProfilePic(File newImage) async {
    emit(LoadingAuthState());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.updateProfilePic(
      newPic: newImage,
    );
    if (response.isSuccess) {
      getIt<LocalDataSource>().saveData("user", response.data!.toJson());
      emit(AuthorizedState(user: response.data!));
    }
  }

  Future<void> updateProfileData(Map<String, dynamic> profileData) async {
    emit(LoadingAuthState());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.updateProfileData(
      data: profileData,
    );
    if (response.isSuccess) {
      getIt<LocalDataSource>().saveData("user", response.data!.toJson());
      emit(AuthorizedState(user: response.data!));
    } else {
      print(response.message);
    }
  }

  Future<void> logout() async {
    getIt<LocalDataSource>().saveData("user", "undefined");
    getIt<LocalDataSource>().saveData("token", "undefined");
    getIt<LocalDataSource>().setIsLogin(false);
    emit(UnAuthorizedState());
  }
}
