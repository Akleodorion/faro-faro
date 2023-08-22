import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_in.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/sign_user_in.dart'
    as si;
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './user_notifier_test.mocks.dart';

@GenerateMocks([LogUserIn, si.SignUserIn])
void main() {
  late MockLogUserIn mockLogUserIn;
  late MockSignUserIn mockSignUserIn;
  late UserNotifier userNotifier;

  setUp(() {
    mockLogUserIn = MockLogUserIn();
    mockSignUserIn = MockSignUserIn();
    userNotifier = UserNotifier(
        logUserInUsecase: mockLogUserIn, signUserInUsecase: mockSignUserIn);
  });

  test(
    "should be Initial",
    () async {
      //arrange
      expect(userNotifier.initialState, Initial());
    },
  );

  group(
    "logUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tUser = User(
          username: 'username',
          email: tEmail,
          phoneNumber: 'phoneNumber',
          id: 9);

      test(
        "should call the user log in method with the right info",
        () async {
          //assert
          when(mockLogUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));
          //act
          await userNotifier.logUserIn(tEmail, tPassword);
          await untilCalled(mockLogUserIn.call(any));
          //arrange

          verify(mockLogUserIn
              .call(const Params(email: tEmail, password: tPassword)));
        },
      );

      test(
        "should emits [loading, loaded] when the connexion is successful",
        () async {
          //arrange
          when(mockLogUserIn.call(any))
              .thenAnswer((_) async => const Right(tUser));
          //act
          final expectedState = [Loading(), Loaded(user: tUser)];

          expectLater(userNotifier.stream, emitsInOrder(expectedState));

          userNotifier.logUserIn(tEmail, tPassword);
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
          userNotifier.logUserIn(tEmail, tPassword);
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
      const tUser = User(
        username: tUsername,
        email: tEmail,
        phoneNumber: tPhoneNumber,
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
              tEmail, tPassword, tPhoneNumber, tUsername);
          //assert
          verify(mockSignUserIn.call(const si.Params(
              email: tEmail,
              password: tPassword,
              username: tUsername,
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
          final expectedState = [Loading(), Loaded(user: tUser)];
          expectLater(userNotifier.stream, emitsInOrder(expectedState));
          //act

          await userNotifier.signUserIn(
              tEmail, tPassword, tPhoneNumber, tUsername);
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
              tEmail, tPassword, tPhoneNumber, tUsername);
        },
      );
    },
  );
}
