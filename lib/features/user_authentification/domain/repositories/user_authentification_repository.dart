import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';

import '../entities/user.dart';

abstract class UserAuthentificationRepository {
  Future<Either<Failure, User?>> logUserIn(String email, String password);
  Future<Either<Failure, User?>> signUserIn(
      String email, String password, String username, String phoneNumber);
  Future<Either<Failure, User?>> autoLogIn(String email, String password);
}
