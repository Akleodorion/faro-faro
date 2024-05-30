// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/domain/entities/user.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/log_user_in.dart';
import './log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthRepository;
  late LogUserIn logUserIn;

  setUp(() {
    mockUserAuthRepository = MockUserAuthentificationRepository();
    logUserIn = LogUserIn(repository: mockUserAuthRepository);
  });

  const tEmail = "test@gmail.com";
  const tPassword = "123456";
  const tToken = "this-is-a-token";
  const tPref = true;
  const user = User(
      username: 'username',
      email: tEmail,
      phoneNumber: 'phoneNumber',
      jwtToken: tToken,
      id: 9);

  test(
    "should call the logUserIn function with the right parameters",
    () async {
      //assert
      when(mockUserAuthRepository.logUserIn(any, any, any))
          .thenAnswer((_) async => const Right(user));
      //act
      await logUserIn
          .call(const Params(email: tEmail, password: tPassword, pref: tPref));
      //arrange
      verify(mockUserAuthRepository.logUserIn(tEmail, tPassword, tPref));
    },
  );
}
