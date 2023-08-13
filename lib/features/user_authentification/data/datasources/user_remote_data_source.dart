import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel?> userLogInRequest(
      {required String email, required String password});
  Future<UserModel?> userSignInRequest({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<UserModel?> userLogInRequest(
      {required String email, required String password}) async {
    return null;
  }

  @override
  Future<UserModel?> userSignInRequest(
      {required String email,
      required String password,
      required String username,
      required String phoneNumber}) async {
    return null;
  }
}
