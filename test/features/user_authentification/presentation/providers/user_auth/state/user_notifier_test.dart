import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_in.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_out.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/sign_user_in.dart'
    as si;
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './user_notifier_test.mocks.dart';

@GenerateMocks(
    [LogUserIn, si.SignUserIn, GetUserInfo, LogInWithToken, LogUserOutUsecase])
void main() {
  late MockLogUserIn mockLogUserIn;
  late MockSignUserIn mockSignUserIn;
  late MockGetUserInfo mockGetUserInfo;
  late MockLogUserOutUsecase mockLogUserOutUsecase;

  late UserNotifier userNotifier;

  setUp(() {
    mockLogUserIn = MockLogUserIn();
    mockSignUserIn = MockSignUserIn();
    mockGetUserInfo = MockGetUserInfo();
    mockLogUserOutUsecase = MockLogUserOutUsecase();
    userNotifier = UserNotifier(
      logUserInUsecase: mockLogUserIn,
      signUserInUsecase: mockSignUserIn,
      logUserOutUsecase: mockLogUserOutUsecase,
    );
  });

  test(
    "initialState test should be loading",
    () async {
      //arrange
      expect(userNotifier.initialState, Unloaded());
    },
  );
  const tSuccessMessage = "Réussi";

  group(
    "logUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tPref = true;
      const tUser = User(
          username: 'username',
          email: tEmail,
          phoneNumber: 'phoneNumber',
          jwtToken: "this is a token",
          id: 9);

      test(
        "should call the user log in method with the right info",
        () async {
          //assert
          when(mockLogUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));
          //act
          await userNotifier.logUserIn(tEmail, tPassword, tPref);
          await untilCalled(mockLogUserIn.call(any));
          //arrange

          verify(mockLogUserIn.call(
              const Params(email: tEmail, password: tPassword, pref: tPref)));
        },
      );

      test(
        "should emits [loading, loaded] when the connexion is successful",
        () async {
          //arrange
          when(mockLogUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));
          //act
          final expectedState = [
            Loading(),
            Loaded(user: tUser, message: tSuccessMessage)
          ];

          expectLater(userNotifier.stream, emitsInOrder(expectedState));

          userNotifier.logUserIn(tEmail, tPassword, tPref);
        },
      );

      test(
        "should emits [loading, Error] when the connexion is unsuccessful",
        () async {
          //arrange
          when(mockLogUserIn.call(any)).thenAnswer((_) async =>
              const Left(ServerFailure(errorMessage: 'no connexion')));
          //assert later
          final expectedState = [
            Loading(),
            Error(message: 'An error as occured')
          ];
          expectLater(userNotifier.stream, emitsInOrder(expectedState));
          // act
          userNotifier.logUserIn(tEmail, tPassword, tPref);
        },
      );
    },
  );

  group(
    "signUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tUsername = "username";
      const tPhoneNumber = "06 06 06 06 06";
      const tToken = "this is a token";
      const tPref = true;
      const tUser = User(
        username: tUsername,
        email: tEmail,
        phoneNumber: tPhoneNumber,
        jwtToken: tToken,
        id: 9,
      );
      test(
        "should call the sign user in usecase with the right info",
        () async {
          //arrange
          when(mockSignUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));
          //act
          await userNotifier.signUserIn(
              tEmail, tPassword, tPhoneNumber, tUsername, tPref);
          //assert
          verify(mockSignUserIn.call(const si.Params(
              email: tEmail,
              password: tPassword,
              username: tUsername,
              pref: tPref,
              phoneNumber: tPhoneNumber)));
        },
      );

      test(
        "should emit [loading, loaded] if the request is successful",
        () async {
          //arrange
          when(mockSignUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));

          //assert later
          final expectedState = [
            Loading(),
            Loaded(user: tUser, message: tSuccessMessage)
          ];
          expectLater(userNotifier.stream, emitsInOrder(expectedState));
          //act

          await userNotifier.signUserIn(
              tEmail, tPassword, tPhoneNumber, tUsername, tPref);
        },
      );

      test(
        "should emit [loading, error] if the request is unsuccessful",
        () async {
          //arrange
          when(mockSignUserIn(any)).thenAnswer((realInvocation) async =>
              const Left(ServerFailure(errorMessage: 'oops')));
          //assert later
          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(userNotifier.stream, emitsInOrder(expectedState));
          //assert
          await userNotifier.signUserIn(
              tEmail, tPassword, tPhoneNumber, tUsername, tPref);
        },
      );
    },
  );

  group(
    "logUserOut",
    () {
      final tDatetime = DateTime.now();
      const tToken =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkZWYyMGYwZC02OGY5LTQ5OTAtYjk4MC';
      final tUserInfo = {
        "email": "chris@gmail.com",
        "password": "123456",
        "token": tToken,
        "datetime": tDatetime,
        "pref": true,
      };

      test(
        "should emit [Loading, Initial]",
        () async {
          //arrange
          when(mockLogUserOutUsecase.execute(jwt: tToken))
              .thenAnswer((realInvocation) async => null);
          when(mockGetUserInfo.call()).thenAnswer((_) async => tUserInfo);
          //act
          final expectedResult = [Loading(), Unloaded()];
          expectLater(userNotifier.stream, emitsInOrder(expectedResult));
          //assert
          await userNotifier.logUserOut(jwt: tToken);
        },
      );
    },
  );
}
