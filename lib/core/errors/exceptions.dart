class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
}

class UtilException implements Exception {
  UtilException();
}

class CacheException implements Exception {}
