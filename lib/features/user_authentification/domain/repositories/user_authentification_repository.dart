import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

import '../entities/user.dart';

abstract class UserAuthentificationRepository {
  // Connecte l'utilisateur avec les identifiants fournis
  Future<Either<Failure, User?>> logUserIn(
      String email, String password, bool pref);

  //Crée un nouvel utilisateurs avec les identifiants fournis et le connecte
  Future<Either<Failure, User?>> signUserIn(String email, String password,
      String username, String phoneNumber, bool pref);

  //récupère les informations de connexions précédentes
  Future<Map<String, dynamic>?> getUserInfo();

  Future<Failure?> logUserOut({required String jwt});

  Future<User?> logInWithToken();

  Future<Either<Failure, String>> requestResetToken({required String email});

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });
}
