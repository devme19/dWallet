class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}

class ServerException implements Exception {
  final int? errorCode;
  final String? errorMessage;

  ServerException({this.errorCode, this.errorMessage});
}
