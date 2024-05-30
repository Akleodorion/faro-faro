// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';

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
