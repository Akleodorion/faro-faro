import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late LogInWithToken logInWithToken;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    logInWithToken =
        LogInWithToken(repository: mockUserAuthentificationRepository);
  });

  const tUserModel = UserModel(
      username: "akleo",
      email: "test@gmail.com",
      phoneNumber: "+22506060606",
      jwtToken: "this is a token",
      id: 9);

  group('LogInWithToken', () {
    test(
      "should return a valid UserModel",
      () async {
        //arrange
        when(mockUserAuthentificationRepository.logInWithToken())
            .thenAnswer((realInvocation) async => tUserModel);
        //act
        final result = await logInWithToken.call();
        //assert
        expect(result, tUserModel);
      },
    );
  });
}
