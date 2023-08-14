import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/usecases/usecase.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

import '../../data/models/user_model.dart';

class SignUserIn implements UseCase<UserModel, Params> {
  SignUserIn({required this.repository});
  final UserAuthentificationRepository repository;

  @override
  Future<Either<Failure, UserModel?>> call(Params params) {
    return repository.signUserIn(
        params.email, params.password, params.username, params.phoneNumber);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;

  const Params(
      {required this.email,
      required this.password,
      required this.username,
      required this.phoneNumber});

  @override
  List<Object?> get props => [email, password, username, phoneNumber];
}
