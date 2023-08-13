// ignore_for_file: constant_identifier_names

import 'dart:convert';

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

const LOG_IN_URL = 'http://localhost:3001/login';
const SIGN_IN_URL = 'http://localhost:3001/signin';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<UserModel?> userLogInRequest(
      {required String email, required String password}) async {
    final url = Uri.parse(LOG_IN_URL);
    final response = await client.post(url, headers: {
      'Content-Type': 'application/json'
    }, body: {
      "user": {"email": email, "password": password}
    });
    final userModel = UserModel.fromJson(json.decode(response.body));
    return userModel;
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
