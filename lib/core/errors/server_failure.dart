import 'package:dio/dio.dart';
import 'package:supermarket/core/config/constants/strings.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  final ServerResponseStatus status;

  ServerFailure({super.message, required this.status});

  factory ServerFailure.formDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          status: ServerResponseStatus.CONNECT_TIMEOUT,
          message: AppStrings.TIMEOUT_ERROR,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          status: ServerResponseStatus.SEND_TIMEOUT,
          message: AppStrings.TIMEOUT_ERROR,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          status: ServerResponseStatus.RECIEVE_TIMEOUT,
          message: AppStrings.TIMEOUT_ERROR,
        );
      case DioExceptionType.badResponse:
        final response = exception.response;
        return ServerFailure(
          status: ServerResponseStatus.values.firstWhere(
            (element) => response?.statusCode == element.code,
            orElse: () => ServerResponseStatus.DEFAULT,
          ),
          message: response?.data.isEmpty ? null : response?.data['error'],
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          status: ServerResponseStatus.CONNECT_TIMEOUT,
          message: AppStrings.CANCEL_ERROR,
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          status: ServerResponseStatus.DEFAULT,
        );
      default:
        return ServerFailure(
          status: ServerResponseStatus.DEFAULT,
        );
    }
  }

  @override
  List<Object?> get props => [super.message, status];
}

enum ServerResponseStatus {
  SUCCESS(200),
  SUCCESS_NO_CONTENT(201),
  BAD_REQUEST(400),
  UNAUTORISED(401),
  FORBIDDEN(403),
  NOT_FOUND(404),
  INTERNAL_SERVER_ERROR(500),
  SERVER_DOWN_ERROR(503),
  CONNECT_TIMEOUT(-1),
  CANCEL(-2),
  RECIEVE_TIMEOUT(-3),
  SEND_TIMEOUT(-4),
  CACHE_ERROR(-5),
  NO_INTERNET_CONNECTION(-6),
  DEFAULT(0);

  final int code;

  const ServerResponseStatus(this.code);
}
