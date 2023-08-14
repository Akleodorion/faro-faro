import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';

abstract class UserAuthentificationRepository {
  Future<Either<Failure, UserModel?>> logUserIn(String email, String password);
  Future<Either<Failure, UserModel?>> signUserIn(
      String email, String password, String username, String phoneNumber);
}
