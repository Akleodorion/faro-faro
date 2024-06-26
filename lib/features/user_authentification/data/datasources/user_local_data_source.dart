// ignore_for_file: constant_identifier_names

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  /// Gets the last cached preference choosen by the user.
  Future<bool?> getLastPref();

  /// Gets the last email and password used for connexion.
  Future<Map<String, dynamic>?> getUserAuth();

  /// Gets the last dateTime when the user was connected
  Future<DateTime?> getLastLoginDatetime();

  ///Gets the last cached JWT token
  Future<String?> getLastCachedToken();

  //Sets the last cached JWT token to empty string
  Future<void>? resetLastCachedTokenAndDateTime();

  /// Stores all the connexion data in the cache
  Future<void>? storeConnexionData({
    required bool pref,
    required Map<String, String> userAuth,
    required String dateTime,
    required String jwtToken,
  });
}

const CACHED_JWT_TOKEN = 'CACHED_JWT_TOKEN';
const CACHED_LOGIN_DATETIME = 'CACHED_LOGIN_DATETIME';
const CACHED_CONNEXION_PREF = 'CACHED_CONNEXION_PREF';
const CACHED_USER_AUTH_DATA = 'CACHED_USER_AUTH_DATA';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<String?> getLastCachedToken() async {
    final jwtToken = sharedPreferences.getString(CACHED_JWT_TOKEN);
    if (jwtToken != null) {
      return sharedPreferences.getString(CACHED_JWT_TOKEN);
    } else {
      return '';
    }
  }

  @override
  Future<DateTime?> getLastLoginDatetime() async {
    final datetimeAsString = sharedPreferences.getString(CACHED_LOGIN_DATETIME);
    if (datetimeAsString != null &&
        DateTime.tryParse(datetimeAsString) != null) {
      return DateTime.parse(datetimeAsString);
    } else {
      return null;
    }
  }

  @override
  Future<bool?> getLastPref() async {
    final pref = sharedPreferences.getBool(CACHED_CONNEXION_PREF);
    if (pref != null) {
      return pref;
    } else {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserAuth() async {
    final userAuthData = sharedPreferences.getString(CACHED_USER_AUTH_DATA);
    if (userAuthData != null) {
      return json.decode(userAuthData);
    } else {
      return {"email": "", "password": ""};
    }
  }

  @override
  Future<void>? storeConnexionData(
      {required bool pref,
      required Map<String, String> userAuth,
      required String dateTime,
      required String jwtToken}) async {
    final clearedUserAuth = {"email": "", "password": ""};

    sharedPreferences.setBool(CACHED_CONNEXION_PREF, pref);
    sharedPreferences.setString(CACHED_USER_AUTH_DATA,
        pref ? json.encode(userAuth) : json.encode(clearedUserAuth));
    sharedPreferences.setString(CACHED_LOGIN_DATETIME, pref ? dateTime : "");
    sharedPreferences.setString(CACHED_JWT_TOKEN, pref ? jwtToken : "");
  }

  @override
  Future<void>? resetLastCachedTokenAndDateTime() async {
    sharedPreferences.setString(CACHED_JWT_TOKEN, "");
    sharedPreferences.setString(CACHED_LOGIN_DATETIME, "");
  }
}
