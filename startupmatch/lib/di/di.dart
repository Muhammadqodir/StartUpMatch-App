import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupmatch/core.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/local/local_data_source.dart';
import 'package:startupmatch/data/remote/remote_data_source.dart';
import 'package:startupmatch/data/test/test_data.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<LocalDataSource>(LocalDataSource());
  getIt.registerSingletonAsync<RemoteDataSource>(() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "undefined";
    return RemoteDataSource(token: token);
  });
  getIt.registerSingleton<TestDataSource>(TestDataSource());
  getIt.registerSingleton<Connectivity>(Connectivity());

  getIt.registerLazySingleton<DataSource>(() {
    if (isTestMode) {
      return getIt<TestDataSource>();
    }
    final connectivityResult = getIt<Connectivity>().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return getIt<LocalDataSource>();
    } else {
      return getIt<RemoteDataSource>();
    }
  });
}
