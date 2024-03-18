import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/usecases/reset_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_test.mocks.dart';

@GenerateMocks([UserAuthentificationRepository])
main() {
  late MockUserAuthentificationRepository mockUserAuthentificationRepository;
  late ResetPasswordUsecase sut;

  setUp(() {
    mockUserAuthentificationRepository = MockUserAuthentificationRepository();
    sut = ResetPasswordUsecase(repository: mockUserAuthentificationRepository);
  });

  group("Reset Password", () {
    const tEmail = "Test1@gmail.com";
    test("Should return a valid string", () async {
      // arrange
      when(mockUserAuthentificationRepository.resetPassword(
              email: anyNamed('email')))
          .thenAnswer((realInvocation) async => const Right(tEmail));
      // act
      final result = await sut.execute(email: tEmail);
      // assert
      expect(result, const Right(tEmail));
    });

    test(
      "Should return a server failure when the call is not successful",
      () async {
        // arrange
        when(mockUserAuthentificationRepository.resetPassword(
                email: anyNamed('email')))
            .thenAnswer(
          (realInvocation) async => const Left(
            ServerFailure(errorMessage: 'oops'),
          ),
        );

        // act
        final result = await sut.execute(email: tEmail);
        // assert
        expect(result, const Left(ServerFailure(errorMessage: 'oops')));
      },
    );
  });
}
