import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/Auth/data/datasources/auth_remote_datasource.dart';
import 'package:supermarket/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart';
import 'package:supermarket/features/Auth/domain/use_cases/google_auth_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/signup_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart';
import 'package:supermarket/features/User/data/datasources/user_local_datasource.dart';
import 'package:supermarket/features/User/data/datasources/user_remote_datasource.dart';
import 'package:supermarket/features/User/data/repositories/user_repository_impl.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';
import '../config/constants/urls.dart';
import 'connection_checker.dart';

final GetIt locator = GetIt.instance;

Future locatorsSetup() async {
  //Config
  locator.registerLazySingleton<Dio>(() {
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
    return dio;
  });
  locator.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerConnectivity());
  locator.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  //Usecases
  locator
      .registerLazySingleton<CheckAppStateUseCase>(() => CheckAppStateUseCase(
            authRepository: locator<AuthRepository>(),
          ));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
        authRepository: locator<AuthRepository>(),
      ));
  locator.registerLazySingleton<SignupUseCase>(() => SignupUseCase(
        authRepository: locator<AuthRepository>(),
      ));
  locator.registerLazySingleton<GoogleAuthUseCase>(() => GoogleAuthUseCase(
        authRepository: locator<AuthRepository>(),
      ));

  //Repositories
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        // connectionChecker: locator<ConnectionChecker>(),
        authRemoteDataSource: locator<AuthRemoteDataSource>(),
        userLocalDataSource: locator<UserLocalDataSource>(),
      ));
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userLocalDataSource: locator<UserLocalDataSource>(),
        userRemoteDataSource: locator<UserRemoteDataSource>(),
        connectionChecker: locator<ConnectionChecker>(),
      ));

  //Data Sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            dioClient: locator<Dio>(),
            googleSignIn: locator<GoogleSignIn>(),
          ));
  locator.registerLazySingleton<UserLocalDataSource>(() =>
      UserLocalDataSourceImpl(
          locator<FlutterSecureStorage>(), locator<SharedPreferences>()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dioClient: locator<Dio>()));
}
