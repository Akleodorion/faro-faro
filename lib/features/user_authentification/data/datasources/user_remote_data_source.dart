// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> userLogInRequest(Map<String, String> logInInfo);
  Future<UserModel> userSignInRequest(
      {required Map<String, String> signInInfo});
}

const LOG_IN_URL = 'http://localhost:3001/login';
const SIGN_IN_URL = 'http://localhost:3001/signin';

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
    return _signInOrLogInRequest(LOG_IN_URL, signInInfo, false);
  }

  Future<UserModel> _signInOrLogInRequest(
      String url, Map<String, String> authInfo, bool isLogin) async {
    final uri = Uri.parse(url);
    final response = await client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"user": authInfo}));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body), isLogin);
    } else {
      throw ServerException();
    }
  }
}
