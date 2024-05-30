// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/user_authentification/domain/repositories/user_authentification_repository.dart';

class RequestResetTokenUsecase {
  final UserAuthentificationRepository repository;

  RequestResetTokenUsecase({
    required this.repository,
  });

  Future<Either<Failure, String>> execute({required String email}) async {
    return await repository.requestResetToken(email: email);
  }
}
