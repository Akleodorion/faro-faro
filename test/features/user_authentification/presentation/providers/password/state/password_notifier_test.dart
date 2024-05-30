// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/request_reset_token.dart';
import 'package:faro_faro/features/user_authentification/domain/usecases/reset_password.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/state/password_notifier.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/state/password_state.dart';
import 'password_notifier_test.mocks.dart';

@GenerateMocks([RequestResetTokenUsecase, ResetPasswordUsecase])
void main() {
  late MockRequestResetTokenUsecase mockRequestResetTokenUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  late PasswordNotifier sut;

  setUp(() {
    mockRequestResetTokenUsecase = MockRequestResetTokenUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();
    sut = PasswordNotifier(
        requestResetTokenUsecase: mockRequestResetTokenUsecase,
        resetPasswordUsecase: mockResetPasswordUsecase);
  });

  group("get initial", () {
    test("should return Initial", () => expect(Initial(), sut.initialState));
  });

  group("request reset token", () {
    const String tEmail = "christian.zap@hotmail.fr";
    test("should make the request to the usecase with the right email",
        () async {
      //arrange
      when(mockRequestResetTokenUsecase.execute(email: anyNamed('email')))
          .thenAnswer((_) async => const Right("token"));

      //act
      await sut.requestResetToken(email: tEmail);
      //assert
      verify(mockRequestResetTokenUsecase.execute(email: tEmail)).called(1);
    });

    group("when the call is successfull", () {
      test("should emit [Loading, Initial]", () async {
        //arrange
        when(mockRequestResetTokenUsecase.execute(email: anyNamed('email')))
            .thenAnswer((_) async => const Right(tEmail));

        //assert later
        final expectedState = [Loading(), Initial()];
        expectLater(sut.stream, emitsInOrder(expectedState));
        //act

        sut.requestResetToken(email: tEmail);
      });
    });
    group("when the call is unsuccessfull", () {
      test("should emit [Loading,Error]", () {
        // arrange
        when(mockRequestResetTokenUsecase.execute(email: anyNamed("email")))
            .thenAnswer(
                (_) async => const Left(ServerFailure(errorMessage: "oops")));
        // assert later
        final expectedState = [Loading(), Error(message: "oops")];
        expectLater(sut.stream, emitsInOrder(expectedState));
        // act
        sut.requestResetToken(email: tEmail);
      });
    });
  });

  group("reset password", () {
    const String tEmail = "test@gmail.com";
    const String tToken = "c2d5e6";
    const String tPassword = "password";
    test("should make the request with the right infos.", () async {
      //arrange
      when(mockResetPasswordUsecase.execute(
              email: anyNamed("email"),
              token: anyNamed("token"),
              newPassword: anyNamed("newPassword")))
          .thenAnswer((_) async => const Right("test"));
      //act
      await sut.resetPassword(
          email: tEmail, token: tToken, newPassword: tPassword);
      //assert
      verify
          .call(mockResetPasswordUsecase.execute(
              email: tEmail, token: tToken, newPassword: tPassword))
          .called(1);
    });

    group("when the call is a success", () {
      test("should emit [Loading, Initial]", () async {
        // arrange
        when(mockResetPasswordUsecase.execute(
                email: anyNamed("email"),
                token: anyNamed("token"),
                newPassword: anyNamed("newPassword")))
            .thenAnswer((realInvocation) async => const Right("good"));
        // assert later
        final expectedState = [Loading(), Initial()];
        expectLater(sut.stream, emitsInOrder(expectedState));
        // act
        sut.resetPassword(email: tEmail, token: tToken, newPassword: tPassword);
      });
    });
    group("when the call is not a success", () {
      test("should emit [Loading, Error]", () async {
        // arrange
        when(mockResetPasswordUsecase.execute(
                email: anyNamed("email"),
                token: anyNamed("token"),
                newPassword: anyNamed("newPassword")))
            .thenAnswer((realInvocation) async =>
                const Left(ServerFailure(errorMessage: "oops")));
        // assert later
        final expectedState = [Loading(), Error(message: "oops")];
        expectLater(sut.stream, emitsInOrder(expectedState));
        // act
        sut.resetPassword(email: tEmail, token: tToken, newPassword: tPassword);
      });
    });
  });
}
