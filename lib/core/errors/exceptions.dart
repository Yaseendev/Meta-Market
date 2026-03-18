import 'package:dio/dio.dart';

class ServerException extends DioException {
  ServerException({required super.requestOptions});
}

class AuthTokenException implements Exception {}