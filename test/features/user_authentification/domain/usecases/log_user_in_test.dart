import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
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
  final tUserModel = UserModel(
      email: 'chris@gmail.com',
      username: "BakiHanma",
      id: id,
      phoneNumber: "06 06 06 06 06");

  test(
    "should log the user in",
    () async {
      //assert
      when(mockUserAuthentificationRepository.logUserIn(any, any))
          .thenAnswer((realInvocation) async => Right(tUserModel));

      //act
      logUserIn(Params(email: tEmail, password: tPassword));
      //arrange
      verify(mockUserAuthentificationRepository.logUserIn(tEmail, tPassword))
          .called(1);
    },
  );
}
