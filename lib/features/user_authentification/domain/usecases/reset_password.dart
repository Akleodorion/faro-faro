import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

class ResetPasswordUsecase {
  final UserAuthentificationRepository repository;

  ResetPasswordUsecase({required this.repository});

  Future<Either<Failure, String>> execute(
      {required String email,
      required String token,
      required String newPassword}) async {
    return await repository.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }
}
