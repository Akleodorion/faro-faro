class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
}

class CacheException implements Exception {}
