import 'package:dartz/dartz.dart';

abstract class UserAuthentificationRepository {
  Future<Either<void, void>>? logUserIn(String email, String password);
  Future<Either<void, void>>? signUserIn(
      String email, String password, String username, String phoneNumber);
}
