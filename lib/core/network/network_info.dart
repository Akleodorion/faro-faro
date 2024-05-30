// Package imports:
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Project imports:
import 'package:faro_faro/core/constants/error_constants.dart';
import 'package:faro_faro/core/errors/exceptions.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> getConnexionStatuts();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connexionChecker;

  NetworkInfoImpl(
    this.connexionChecker,
  );
  @override
  Future<bool> get isConnected => connexionChecker.hasConnection;

  @override
  Future<bool> getConnexionStatuts() async {
    if (await isConnected) {
      return true;
    }
    throw ServerException(errorMessage: ErrorConstants.noInternetConnexion);
  }
}
