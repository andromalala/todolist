class ServerException implements Exception {
  final String message;
  final int statusCode;
  final dynamic body;
  ServerException({
    required this.statusCode,
    required this.message,
    required this.body,
  });
}

class SocketException implements Exception {
  final String message;
  SocketException({required this.message});
}

class CacheException implements Exception {}
