// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> userLogInRequest(Map<String, String> logInInfo);
  Future<UserModel?> userLogInWithToken(String token);
  Future<UserModel> userSignInRequest(
      {required Map<String, String> signInInfo});
}

const LOG_IN_URL = 'http://localhost:3001/login';
const SIGN_IN_URL = 'http://localhost:3001/signup';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<UserModel> userLogInRequest(Map<String, String> logInInfo) async {
    return _signInOrLogInRequest(LOG_IN_URL, logInInfo, true);
  }

  @override
  Future<UserModel> userSignInRequest(
      {required Map<String, String> signInInfo}) async {
    return _signInOrLogInRequest(SIGN_IN_URL, signInInfo, false);
  }

  Future<UserModel> _signInOrLogInRequest(
      String url, Map<String, String> authInfo, bool isLogin) async {
    final uri = Uri.parse(url);
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"user": authInfo}),
    );
    if (response.statusCode == 200) {
      final jwtToken = response.headers["authorization"]!.split(' ');
      return UserModel.fromJson(
          json.decode(response.body), isLogin, jwtToken[1]);
    } else {
      if (isLogin) {
        final message = response.body;
        throw ServerException(errorMessage: message);
      } else {
        final message = json.decode(response.body)["status"]["message"];
        throw ServerException(errorMessage: message);
      }
    }
  }

  @override
  Future<UserModel?> userLogInWithToken(
    String token,
  ) async {
    final uri = Uri.parse(LOG_IN_URL);

    // faire la requête de logIn  uniquement avec le Token
    final response = await client.post(uri, headers: {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    });
    // renvoyer le UserModel
    if (response.statusCode == 200) {
      final jwtToken = response.headers["authorization"]!.split(' ');
      return UserModel.fromJson(json.decode(response.body), true, jwtToken[1]);
    } else {
      return null;
    }
  }
}
