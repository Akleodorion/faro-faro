import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  /// Gets the last cached preference choosen by the user.
  Future<bool?> getLastPref();

  /// Gets the last email and password used for connexion.
  Future<Map<String, String>?> getUserAuth();

  /// Gets the last dateTime when the user was connected
  Future<DateTime?> getLastLoginDatetime();

  ///Gets the last cached JWT token
  Future<String?> getLastCachedToken();

  Future<void>? storeConnexionData({
    required bool pref,
    required Map<String, String> userAuth,
    required DateTime dateTime,
    required String jwtToken,
  });
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<String?> getLastCachedToken() async {
    return null;
  }

  @override
  Future<DateTime?> getLastLoginDatetime() async {
    return null;
  }

  @override
  Future<bool?> getLastPref() async {
    return null;
  }

  @override
  Future<Map<String, String>?> getUserAuth() async {
    return null;
  }

  @override
  Future<void>? storeConnexionData(
      {required bool pref,
      required Map<String, String> userAuth,
      required DateTime dateTime,
      required String jwtToken}) async {}
}
