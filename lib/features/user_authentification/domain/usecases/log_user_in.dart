import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class LogUserIn implements UseCase<bool, Params> {
  LogUserIn({required this.repository});

  final UserAuthentificationRepository repository;

  @override
  Future<Either<Failure, bool>>? call(Params params) {
    return repository.logUserIn(params.email, params.password);
  }
}

class Params extends Equatable {
  const Params({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
