// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/reset_password.dart';
import 'reset_password_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
void main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late ResetPasswordUsecase sut;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    sut = ResetPasswordUsecase(repository: mockUserAuthentificationRepository);
  });

  group('Reset Password Usecase', () {
    const String tEmail = "test@gmail.com";
    const String tToken = "b4c2d6";
    const String tPassword = "password";
    test("should return Right String if the call is successful", () async {
      // arrange
      when(mockUserAuthentificationRepository.resetPassword(
              email: anyNamed("email"),
              token: anyNamed("token"),
              newPassword: anyNamed("newPassword")))
          .thenAnswer((realInvocation) async => const Right("Answer"));
      // assert
      final result = await sut.execute(
          email: tEmail, token: tToken, newPassword: tPassword);
      // act
      expect(result, const Right("Answer"));
    });

    test("should return Left ServerFailure if the call is unsuccessful",
        () async {
      // arrange
      when(mockUserAuthentificationRepository.resetPassword(
              email: anyNamed("email"),
              token: anyNamed("token"),
              newPassword: anyNamed("newPassword")))
          .thenAnswer((realInvocation) async =>
              const Left(ServerFailure(errorMessage: "oops")));
      // assert
      final result = await sut.execute(
          email: tEmail, token: tToken, newPassword: tPassword);
      // act
      expect(result, const Left(ServerFailure(errorMessage: "oops")));
    });
  });
}
