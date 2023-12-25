import 'package:faro_clean_tdd/core/constants/error_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
