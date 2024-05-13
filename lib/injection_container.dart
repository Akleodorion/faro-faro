import 'package:faro_clean_tdd/core/util/date_time_util/date_time_util.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_notifier.dart';
import 'package:faro_clean_tdd/internal_features/contact_list/contact_list.dart';
import 'package:faro_clean_tdd/core/util/location/location_repo.dart';
import 'package:faro_clean_tdd/features/address/data/datasources/address_remote_data_source.dart';
import 'package:faro_clean_tdd/features/address/data/repositories/address_repository_impl.dart';
import 'package:faro_clean_tdd/features/address/domain/repositories/address_repository.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_current_location_address.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_notifier.dart';
import 'package:faro_clean_tdd/features/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:faro_clean_tdd/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:faro_clean_tdd/features/contacts/domain/repositories/contact_repository.dart';
import 'package:faro_clean_tdd/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_notifier.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/close_an_event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/activate_event/state/activate_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/close_event/state/close_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_notifier.dart';
import 'package:faro_clean_tdd/features/members/data/datasources/member_remote_data_source.dart';
import 'package:faro_clean_tdd/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/create_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/fetch_members_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_notifier.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_notifier.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/fetch_members/state/fetch_members_notifier.dart';
import 'package:faro_clean_tdd/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_clean_tdd/features/pick_image/data/repositories/picked_image_repository_impl.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/repositories/picked_image_repository.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:faro_clean_tdd/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/activate_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/update_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/request_reset_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/reset_password.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/password/state/password_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'core/network/network_info.dart';
import 'features/events/data/datasources/event_remote_data_source.dart';
import 'features/events/data/repositories/event_repository_impl.dart';
import 'features/events/domain/repositories/event_repository.dart';
import 'features/events/domain/usecases/fetch_all_events.dart';
import 'features/events/presentation/providers/fetch_event/state/fetch_event_notifier.dart';
import 'features/user_authentification/data/datasources/user_local_data_source.dart';
import 'features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'features/user_authentification/data/repositories/user_authentification_repository_impl.dart';
import 'features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'features/user_authentification/domain/usecases/get_user_info.dart';
import 'features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'features/user_authentification/domain/usecases/log_user_in.dart';
import 'features/user_authentification/domain/usecases/sign_user_in.dart';
import 'features/user_authentification/presentation/providers/user_auth/state/user_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - userAuth - Password - logged In
  sl.registerFactory(() =>
      LoggedInNotifier(getUserInfoUsecase: sl(), logInWithTokenUsecase: sl()));

  sl.registerFactory(() => UserNotifier(
        logUserInUsecase: sl(),
        signUserInUsecase: sl(),
        getUserInfoUsecase: sl(),
        logUserOutUsecase: sl(),
      ));

  sl.registerFactory(() => PasswordNotifier(
        requestResetTokenUsecase: sl(),
        resetPasswordUsecase: sl(),
      ));

  // usecases
  sl.registerLazySingleton(() => LogUserIn(repository: sl()));
  sl.registerLazySingleton(() => LogInWithToken(repository: sl()));
  sl.registerLazySingleton(() => SignUserIn(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfo(repository: sl()));
  sl.registerLazySingleton(() => LogUserOutUsecase(repository: sl()));
  sl.registerLazySingleton(() => RequestResetTokenUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<UserAuthentificationRepository>(() =>
      UserAuthentificationRepositoryImpl(
          dateTimeUtil: sl(),
          localDataSource: sl(),
          remoteDataSource: sl(),
          networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  //! Features - Fetch Event - Post Event - Close Event - Activate Event
  sl.registerFactory(() => FetchEventNotifier(
        fetchAllEventsUsecase: sl(),
      ));
  //
  sl.registerFactory(() => PostEventNotifier(
        postAnEventUsecase: sl(),
      ));

  sl.registerFactory(() => ActivateEventNotifier(
        activateAnEventUsecase: sl(),
      ));
  sl.registerFactory(() => CloseEventNotifier(
        closeAnEventUsecase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => FetchAllEvents(repository: sl()));
  sl.registerLazySingleton(() => PostAnEvent(repository: sl()));
  sl.registerLazySingleton(() => CloseAnEvent(repository: sl()));
  sl.registerLazySingleton(() => ActivateAnEvent(repository: sl()));

  // Repository
  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<EventRemoteDatasource>(
      () => EventRemoteDatasourceImpl(client: sl()));

  //! Features - Fetch Tickets - Create Ticket - Update Ticket - Activate Ticket
  sl.registerFactory(() => FetchTicketsNotifier(usecase: sl()));
  sl.registerFactory(() => CreateTicketNotifier(usecase: sl()));
  sl.registerFactory(() => UpdateTicketNotifier(usecase: sl()));
  sl.registerFactory(() => ActivateTicketNotifier(usecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => FetchUserTicketsUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateTicketUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTicketUsecase(repository: sl()));
  sl.registerLazySingleton(() => ActivateTicketUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<TicketRepository>(
      () => TicketRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<TicketRemoteDataSource>(
      () => TicketRemoteDataSourceImpl(client: sl()));

  //! Features - Create Member - Delete Member - Fetch Member
  sl.registerFactory(() => FetchMemberNotifier(usecase: sl()));
  sl.registerFactory(() => CreateMemberNotifier(usecase: sl()));
  sl.registerFactory(() => DeleteMemberNotifier(usecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => FetchMembersUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateMemberUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteMemberUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<MemberRepository>(
      () => MemberRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(client: sl()));

  //! Features - Get Address
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

  //! Features - Pick Image
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

  //! Features - FetchContactList
  sl.registerLazySingleton(() => ContactNotifier(usecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => FetchContactUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), contactList: sl()));

  // Datasource
  sl.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ContactList>(() => ContactListImpl());
  sl.registerLazySingleton(() => LocationRepoImpl(location: sl()));
  sl.registerLazySingleton<DateTimeUtil>(() => DateTimeUtilImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => ImagePicker());
}
