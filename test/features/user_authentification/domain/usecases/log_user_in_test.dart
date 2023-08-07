import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_user_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late LogUserIn logUserIn;
  late String tEmail;
  late String tPassword;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    logUserIn = LogUserIn(repository: mockUserAuthentificationRepository);
    tEmail = 'chris@gmail.com';
    tPassword = "blabla123";
  });

  test(
    "should call the LogUserIn function",
    () async {
      //assert
      when(mockUserAuthentificationRepository.logUserIn(any, any))
          .thenAnswer((realInvocation) async => const Right(null));

      //act
      logUserIn.logUserIn(tEmail, tPassword);
      //arrange
      verify(mockUserAuthentificationRepository.logUserIn(any, any)).called(1);
    },
  );
}
