import 'package:faro_clean_tdd/core/util/get_location.dart';
import 'package:faro_clean_tdd/features/address/data/datasources/address_remote_data_source.dart';
import 'package:faro_clean_tdd/features/address/data/repositories/address_repository_impl.dart';
import 'package:faro_clean_tdd/features/address/domain/repositories/address_repository.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_current_location_address.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_notifier.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_clean_tdd/features/pick_image/data/repositories/picked_image_repository_impl.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/repositories/picked_image_repository.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'core/network/network_info.dart';
import 'core/util/datetime_comparator.dart';
import 'features/events/data/datasources/event_remote_data_source.dart';
import 'features/events/data/repositories/event_repository_impl.dart';
import 'features/events/domain/repositories/event_repository.dart';
import 'features/events/domain/usecases/fetch_all_events.dart';
import 'features/events/presentation/providers/state/event_notifier.dart';
import 'features/user_authentification/data/datasources/user_local_data_source.dart';
import 'features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'features/user_authentification/data/repositories/user_authentification_repository_impl.dart';
import 'features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'features/user_authentification/domain/usecases/get_user_info.dart';
import 'features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'features/user_authentification/domain/usecases/log_user_in.dart';
import 'features/user_authentification/domain/usecases/sign_user_in.dart';
import 'features/user_authentification/presentation/providers/state/user_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  // Features - userAuth
  sl.registerFactory(() => UserNotifier(
      logInWithTokenUsecase: sl(),
      logUserInUsecase: sl(),
      signUserInUsecase: sl(),
      getUserInfoUsecase: sl()));

  // usecases
  sl.registerLazySingleton(() => LogUserIn(repository: sl()));
  sl.registerLazySingleton(() => LogInWithToken(repository: sl()));
  sl.registerLazySingleton(() => SignUserIn(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfo(repository: sl()));

  // Repository
  sl.registerLazySingleton<UserAuthentificationRepository>(() =>
      UserAuthentificationRepositoryImpl(
          dateTimeComparator: sl(),
          localDataSource: sl(),
          remoteDataSource: sl(),
          networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // Features - Fetch Event
  sl.registerFactory(() =>
      EventNotifier(fetchAllEventsUsecase: sl(), postAnEventUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => FetchAllEvents(repository: sl()));
  sl.registerLazySingleton(() => PostAnEvent(repository: sl()));

  // Repository
  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<EventRemoteDatasource>(
      () => EventRemoteDatasourceImpl(client: sl()));

  // Features - Get Address
  sl.registerFactory(() => AddressNotifier(
      getCurrentLocationAddressUsecase: sl(),
      getSelectedLocationAddressUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetCurrentLocationAddress(repository: sl()));
  sl.registerLazySingleton(() => GetSelectedLocationAddress(repository: sl()));

  // Repository
  sl.registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImpl(remoteDataSource: sl()));

  // Datasource
  sl.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(client: sl(), location: sl()));

  // Features - Pick Image
  sl.registerFactory(
      () => PickedImageNotifier(pickImageFromGaleryUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => PickImageFromGalery(repository: sl()));

  // Repository
  sl.registerLazySingleton<PickedImageRepository>(
      () => PickedImageRepositoryImpl(repository: sl()));

  // Datasource
  sl.registerLazySingleton<PickedImageLocalDataSource>(
      () => PickedImageLocalDataSourceImpl(imagePicker: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => GetLocationImpl(location: sl()));
  sl.registerLazySingleton<DateTimeComparator>(() => DateTimeComparatorImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => ImagePicker());
}
