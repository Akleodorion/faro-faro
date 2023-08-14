import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/sign_user_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late SignUserIn signUserIn;
  late String tEmail;
  late String tPassword;
  late String tUsername;
  late String tPhoneNumber;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    signUserIn = SignUserIn(repository: mockUserAuthentificationRepository);
    tEmail = 'chris@gmail.com';
    tPassword = "blabla123";
    tUsername = "BakiHanma";
    tPhoneNumber = "06 06 06 06 06";
  });
  final tUserModel = UserModel(
      email: 'chris@gmail.com',
      username: "BakiHanma",
      id: id,
      phoneNumber: "06 06 06 06 06");

  test(
    "should sign the user in",
    () async {
      //assert
      when(mockUserAuthentificationRepository.signUserIn(any, any, any, any))
          .thenAnswer((realInvocation) async => Right(tUserModel));

      //act
      signUserIn(Params(
          email: tEmail,
          password: tPassword,
          username: tUsername,
          phoneNumber: tPhoneNumber));

      //arrange
      verify(mockUserAuthentificationRepository.signUserIn(
          tEmail, tPassword, tUsername, tPhoneNumber));
    },
  );
}
