import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupmatch/core.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/local/local_data_source.dart';
import 'package:startupmatch/data/remote/remote_data_source.dart';
import 'package:startupmatch/data/test/test_data.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  getIt.registerLazySingletonAsync<RemoteDataSource>(() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "undefined";
    return RemoteDataSource(token: token);
  });
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());
  getIt.registerLazySingleton<TestDataSource>(() => TestDataSource());

  getIt.registerFactoryAsync<DataSource>(() async {
    final internetConnection = getIt<InternetConnection>();
    if (isTestMode) {
      return getIt<TestDataSource>();
    }
    if (await internetConnection.hasInternetAccess) {
      return await getIt.getAsync<RemoteDataSource>();
    } else {
      return getIt<LocalDataSource>();
    }
  });
}
