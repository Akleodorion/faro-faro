import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/get_user_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/log_in_with_token.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_notifier.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../providers/user_auth/state/user_notifier_test.mocks.dart';

@GenerateMocks([GetUserInfo, LogInWithToken])
void main() {
  late MockGetUserInfo mockGetUserInfo;
  late MockLogInWithToken mockLogInWithToken;
  late LoggedInNotifier sut;

  setUp(() {
    mockGetUserInfo = MockGetUserInfo();
    mockLogInWithToken = MockLogInWithToken();
    sut = LoggedInNotifier(
      getUserInfoUsecase: mockGetUserInfo,
      logInWithTokenUsecase: mockLogInWithToken,
    );
  });

  group('logInWithToken', () {
    group('when the call is unsucessfull', () {
      const tUserInfoMap = {
        "email": "test@gmail.com",
        "password": "1234567",
      };
      test('should emit Unloaded', () async {
        //arrange
        when(mockLogInWithToken.call()).thenAnswer((_) async => null);
        when(mockGetUserInfo.call()).thenAnswer((_) async => tUserInfoMap);
        final expectedResult = [Unloaded(userInfo: tUserInfoMap)];
        //assert late
        expectLater(sut.stream, emitsInOrder(expectedResult));
        //assert
        sut.logInWithToken();
      });
    });

    group('when the call is sucessfull', () {
      const tUser = UserModel(
          email: "test@email.com",
          username: "username",
          id: 1,
          jwtToken: "jwtToken",
          phoneNumber: "+225 08 08 08 08 08");
      test('should emit Loaded', () async {
        //arrange
        when(mockLogInWithToken.call()).thenAnswer((_) async => tUser);
        final expectedResult = [Loaded(user: tUser, message: "succes")];
        //assert late
        expectLater(sut.stream, emitsInOrder(expectedResult));
        //assert
        sut.logInWithToken();
      });
    });
  });

  group('statusToUnloaded', () {
    const tUserInfoMap = {
      "email": "test@gmail.com",
      "password": "1234567",
    };
    test('should emit Loading, Unloaded', () async {
      //arrange
      when(mockGetUserInfo.call()).thenAnswer((_) async => tUserInfoMap);
      //assert later
      final expectedResult = [Loading(), Unloaded(userInfo: tUserInfoMap)];
      expectLater(sut.stream, emitsInOrder(expectedResult));
      //act
      sut.statusToUnloaded();
    });
  });

  group('statusToLoaded', () {
    const tUser = UserModel(
        email: "test@email.com",
        username: "username",
        id: 1,
        jwtToken: "jwtToken",
        phoneNumber: "+225 08 08 08 08 08");
    test('should emit Loading, Unloaded', () async {
      //arrange
      //assert later
      final expectedResult = [
        Loading(),
        Loaded(user: tUser, message: "success")
      ];
      expectLater(sut.stream, emitsInOrder(expectedResult));
      //act
      sut.statusToLoaded(tUser);
    });
  });
}
