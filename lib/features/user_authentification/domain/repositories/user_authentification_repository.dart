import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';

abstract class UserAuthentificationRepository {
  Future<Either<Failure, bool>>? logUserIn(String email, String password);
  Future<Either<Failure, bool>>? signUserIn(
      String email, String password, String username, String phoneNumber);
}
