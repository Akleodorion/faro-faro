import 'dart:convert';

import 'package:faro_clean_tdd/core/constants/server_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> userLogInRequest(Map<String, String> logInInfo);
  Future<UserModel?> userLogInWithToken(String token);
  Future<UserModel> userSignInRequest(
      {required Map<String, String> signInInfo});

  Future<void> userLogOutRequest({required String jwt});
  Future<String> requestResetToken({required String email});
  Future<String> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<UserModel> userLogInRequest(Map<String, String> logInInfo) async {
    return _signInOrLogInRequest(ServerConstants.logInUrl, logInInfo, true);
  }

  @override
  Future<UserModel> userSignInRequest(
      {required Map<String, String> signInInfo}) async {
    return _signInOrLogInRequest(ServerConstants.signInUrl, signInInfo, false);
  }

  Future<UserModel> _signInOrLogInRequest(
      String url, Map<String, String> authInfo, bool isLogin) async {
    final uri = Uri.parse(url);

    try {
      final response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({"user": authInfo}),
      );

      if (response.statusCode == 200) {
        final jwtToken = response.headers["authorization"]!.split(' ');
        return UserModel.fromJson(
            json.decode(response.body), isLogin, jwtToken[1]);
      } else {
        if (isLogin) {
          final message = json.decode(response.body)["error"];

          throw ServerException(errorMessage: message);
        } else {
          final message = json.decode(response.body)["status"]["message"];
          throw ServerException(errorMessage: message);
        }
      }
    } on http.ClientException catch (error) {
      throw ServerException(errorMessage: error.message);
    }
  }

  @override
  Future<UserModel?> userLogInWithToken(
    String token,
  ) async {
    final uri = Uri.parse(ServerConstants.logInUrl);

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

  @override
  Future<void> userLogOutRequest({required String jwt}) async {
    final uri = Uri.parse(ServerConstants.logOutUrl);

    final response = await http.delete(
      uri,
      headers: {
        'Authorization': "Bearer $jwt",
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException(errorMessage: 'an error has occured');
    }
  }

  @override
  Future<String> requestResetToken({required String email}) async {
    final uri = Uri.parse(ServerConstants.requestResetTokenUrl);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({"email": email}),
    );

    if (response.statusCode == 200) {
      return "Le code a été envoyé à l'adresse e-mail.";
    }

    if (response.statusCode == 404) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    }

    throw ServerException(
        errorMessage: "une erreur s'est produite veuillez ré-éssayer.");
  }

  @override
  Future<String> resetPassword(
      {required String email,
      required String token,
      required String newPassword}) async {
    final uri = Uri.parse(ServerConstants.resetPasswordUrl);
    final String params =
        json.encode({"email": email, "token": token, "password": newPassword});

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: params,
    );

    if (response.statusCode == 200) {
      return "Le mot de passe à été changé avec succès";
    }
    if (response.statusCode == 404) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    }
    throw ServerException(
        errorMessage: json.decode(response.body)["errors"][0]);
  }
}
