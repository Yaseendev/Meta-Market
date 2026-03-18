import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/features/User/data/datasources/user_local_datasource.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final UserLocalDataSource _authLocalDataSource;

  const AuthInterceptor(this._authLocalDataSource);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authToken = await _authLocalDataSource.getToken();
    options.headers
        .putIfAbsent('Authorization', () => 'Bearer ${authToken ?? ''}');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
