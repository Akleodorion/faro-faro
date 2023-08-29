import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/auto_log_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late AutoLogIn autoLogIn;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    autoLogIn = AutoLogIn(repository: mockUserAuthentificationRepository);
  });

  const tEmail = "chris@gmail.com";
  const tPassword = "123456";
  const user = User(
      username: 'username', email: tEmail, phoneNumber: 'phoneNumber', id: 9);

  test(
    "should log the user in",
    () async {
      //arrange
      when(mockUserAuthentificationRepository.autoLogIn(any, any))
          .thenAnswer((realInvocation) async => const Right(user));
      //act
      await autoLogIn.call(const Params(email: tEmail, password: tPassword));
      //assert
      verify(mockUserAuthentificationRepository.autoLogIn(tEmail, tPassword));
    },
  );
}
