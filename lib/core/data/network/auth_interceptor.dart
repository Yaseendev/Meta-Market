import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/features/Auth/data/datasources/local/auth_local_data_source.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _authLocalDataSource;

  const AuthInterceptor(this._authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authToken = await _authLocalDataSource.getToken();
    if (authToken?.isNotEmpty ?? false) {
      options.headers.putIfAbsent(
        'Authorization',
        () => 'Bearer ${authToken ?? ''}',
      );
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
