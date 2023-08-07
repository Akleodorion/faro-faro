import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

import '../../../../core/errors/failures.dart';

class LogUserIn {
  LogUserIn({required this.repository});

  final UserAuthentificationRepository repository;

  Future<Either<Failure, void>>? logUserIn(String email, String password) {
    repository.logUserIn(email, password);
  }
}
