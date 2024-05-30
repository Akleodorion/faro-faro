// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class UserAuthentificationRepository {
  Future<Either<Failure, User>> logUserIn(
      String email, String password, bool pref);

  Future<Either<Failure, User>> signUserIn(String email, String password,
      String username, String phoneNumber, bool pref);

  Future<Map<String, dynamic>> getUserInfo();

  Future<Failure?> logUserOut({required String jwt});

  Future<User?> logInWithToken();

  Future<Either<Failure, String>> requestResetToken({required String email});
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });
}
