import 'package:bloc/bloc.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/data/local/local_data_source.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  Future<void> checkAuth() async {
    emit(LoadingAuthState());
    if (await getIt<LocalDataSource>().isLogin()) {
      try {
        emit(
          AuthorizedState(user: (await getIt<LocalDataSource>().getUser())!),
        );
      } catch (e, s) {
        emit(ErrorAuthState(title: e.toString(), message: s.toString()));
      }
    } else {
      emit(UnAuthorizedState());
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoadingAuthState());

    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.login(
      email,
      password,
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

  Future<void> register(
    String fullName,
    String email,
    String password,
    String userType,
  ) async {
    emit(LoadingAuthState());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<User> response = await dataSource.register(
      email,
      password,
      fullName,
      userType,
    );
    if (response.isSuccess) {
      getIt<LocalDataSource>().saveData("user", response.data!.toJson());
      getIt<LocalDataSource>().saveData("user", response.data!.token);
      getIt<LocalDataSource>().setIsLogin(true);
      emit(AuthorizedState(user: response.data!));
    } else {
      emit(ErrorAuthState(title: response.title, message: response.message));
    }
  }

  Future<void> logout() async {
    getIt<LocalDataSource>().saveData("user", "undefined");
    getIt<LocalDataSource>().saveData("token", "undefined");
    getIt<LocalDataSource>().setIsLogin(false);
    emit(UnAuthorizedState());
  }
}
