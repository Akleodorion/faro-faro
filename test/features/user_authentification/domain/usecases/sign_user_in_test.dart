// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/domain/entities/user.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/sign_user_in.dart';
import 'log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late SignUserIn signUserIn;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    signUserIn = SignUserIn(repository: mockUserAuthentificationRepository);
  });
  const tEmail = 'chris@gmail.com';
  const tPassword = "blabla123";
  const tUsername = "BakiHanma";
  const tPhoneNumber = "06 06 06 06 06";
  const tToken = "this-is-a-token";
  const tPref = true;

  const tUser = User(
      email: tEmail,
      username: tUsername,
      id: 9,
      jwtToken: tToken,
      phoneNumber: tPhoneNumber);

  test(
    "should call the signUserIn function with the right parameters",
    () async {
      //assert
      when(mockUserAuthentificationRepository.signUserIn(
              any, any, any, any, any))
          .thenAnswer((realInvocation) async => const Right(tUser));

      //act
      signUserIn(const Params(
          email: tEmail,
          password: tPassword,
          username: tUsername,
          pref: tPref,
          phoneNumber: tPhoneNumber));

      //arrange
      verify(mockUserAuthentificationRepository.signUserIn(
          tEmail, tPassword, tUsername, tPhoneNumber, tPref));
    },
  );
}
