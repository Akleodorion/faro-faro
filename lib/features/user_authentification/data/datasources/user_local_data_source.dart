import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';

abstract class UserLocalDataSource {
  /// Throws a [CacheException] for all errors.
  Future<void>? storeUserAuthInfo({required UserModel userModel});
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void>? storeUserAuthInfo({required UserModel userModel}) async {}
}
