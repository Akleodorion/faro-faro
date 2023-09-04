import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class LogUserIn implements UseCase<User?, Params> {
  LogUserIn({required this.repository});

  final UserAuthentificationRepository repository;

  @override
  Future<Either<Failure, User?>> call(Params params) async {
    return await repository.logUserIn(
        params.email, params.password, params.pref);
  }
}

class Params extends Equatable {
  const Params(
      {required this.email, required this.password, required this.pref});

  final String email;
  final String password;
  final bool pref;

  @override
  List<Object?> get props => [email, password, pref];
}
