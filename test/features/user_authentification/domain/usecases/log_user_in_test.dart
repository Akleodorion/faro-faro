import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
  const user = User(
      username: 'username', email: tEmail, phoneNumber: 'phoneNumber', id: 9);

  test(
    "should log the user in",
    () async {
      //assert
      when(mockUserAuthRepository.logUserIn(any, any))
          .thenAnswer((_) async => const Right(user));
      //act
      await logUserIn.call(const Params(email: tEmail, password: tPassword));
      //arrange
      verify(mockUserAuthRepository.logUserIn(tEmail, tPassword));
    },
  );
}
