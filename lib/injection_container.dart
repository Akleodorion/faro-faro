import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/repositories/user_authentification_repository_impl.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_in.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/sign_user_in.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  // Features - userAuth

  sl.registerFactory(
    () => UserNotifier(
      logUserInUsecase: sl(),
      signUserInUsecase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => LogUserIn(repository: sl()));
  sl.registerLazySingleton(() => SignUserIn(repository: sl()));

  // Repository

  sl.registerLazySingleton<UserAuthentificationRepository>(() =>
      UserAuthentificationRepositoryImpl(
          localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Datasource

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
