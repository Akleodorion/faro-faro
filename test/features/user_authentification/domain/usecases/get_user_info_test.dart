import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_user_in_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late GetUserInfo getUserInfo;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    getUserInfo = GetUserInfo(repository: mockUserAuthentificationRepository);
  });

  final userLogInfo = {
    "email": "chris@gmail.com",
    "password": "123456",
    "token": "this is a token",
    "datetime": DateTime.now(),
    "pref": true,
  };

  group(
    "getUserInfo",
    () {
      test(
        "should retrieve the user stored informations",
        () async {
          //arrange
          when(mockUserAuthentificationRepository.getUserInfo())
              .thenAnswer((_) async => userLogInfo);
          //act
          final result = await getUserInfo.call();
          //assert
          expect(result, userLogInfo);
        },
      );
    },
  );
}
