import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/data/network/auth_inerceptor.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dioDevInstance {
    final dio = Dio(
      BaseOptions(
        baseUrl: Urls.BASE_API,
        headers: {
          'Accept': 'application/json',
        },
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        sendTimeout: const Duration(seconds: 50),
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));
    dio.interceptors.add(getIt<AuthInterceptor>());
    return dio;
  }

  @lazySingleton
  GoogleSignIn get googleSignIIn => GoogleSignIn();
}
