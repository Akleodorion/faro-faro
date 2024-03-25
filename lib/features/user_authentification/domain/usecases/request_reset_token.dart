import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

class RequestResetTokenUsecase {
  final UserAuthentificationRepository repository;

  RequestResetTokenUsecase({
    required this.repository,
  });

  Future<Either<Failure, String>> execute({required String email}) async {
    return await repository.requestResetToken(email: email);
  }
}
