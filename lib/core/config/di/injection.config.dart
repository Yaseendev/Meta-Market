// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supermarket/core/config/di/injectable_module.dart' as _i906;
import 'package:supermarket/core/data/network/auth_inerceptor.dart' as _i875;
import 'package:supermarket/core/services/connection_checker.dart' as _i369;
import 'package:supermarket/features/Auth/data/datasources/auth_remote_datasource.dart'
    as _i636;
import 'package:supermarket/features/Auth/data/repositories/auth_repository_impl.dart'
    as _i799;
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart'
    as _i900;
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart'
    as _i297;
import 'package:supermarket/features/Auth/domain/use_cases/google_auth_use_case.dart'
    as _i869;
import 'package:supermarket/features/Auth/domain/use_cases/login_use_case.dart'
    as _i615;
import 'package:supermarket/features/Auth/domain/use_cases/signup_use_case.dart'
    as _i421;
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart'
    as _i400;
import 'package:supermarket/features/User/data/datasources/user_local_datasource.dart'
    as _i744;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => injectableModule.secureStorage);
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioDevInstance);
    gh.lazySingleton<_i116.GoogleSignIn>(() => injectableModule.googleSignIIn);
    gh.lazySingleton<_i744.UserLocalDataSource>(
        () => _i744.UserLocalDataSourceImpl(
              gh<_i558.FlutterSecureStorage>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.lazySingleton<_i369.ConnectionChecker>(
        () => _i369.ConnectionCheckerConnectivity(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i636.AuthRemoteDataSource>(
        () => _i636.AuthRemoteDataSourceImpl(
              dioClient: gh<_i361.Dio>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
            ));
    gh.lazySingleton<_i875.AuthInterceptor>(
        () => _i875.AuthInterceptor(gh<_i744.UserLocalDataSource>()));
    gh.lazySingleton<_i900.AuthRepository>(() => _i799.AuthRepositoryImpl(
          userLocalDataSource: gh<_i744.UserLocalDataSource>(),
          authRemoteDataSource: gh<_i636.AuthRemoteDataSource>(),
        ));
    gh.lazySingleton<_i869.GoogleAuthUseCase>(() =>
        _i869.GoogleAuthUseCase(authRepository: gh<_i900.AuthRepository>()));
    gh.lazySingleton<_i297.CheckAppStateUseCase>(() =>
        _i297.CheckAppStateUseCase(authRepository: gh<_i900.AuthRepository>()));
    gh.lazySingleton<_i421.SignupUseCase>(
        () => _i421.SignupUseCase(authRepository: gh<_i900.AuthRepository>()));
    gh.lazySingleton<_i615.LoginUseCase>(
        () => _i615.LoginUseCase(authRepository: gh<_i900.AuthRepository>()));
    gh.factory<_i400.AuthBloc>(() => _i400.AuthBloc(
          gh<_i615.LoginUseCase>(),
          gh<_i421.SignupUseCase>(),
          gh<_i869.GoogleAuthUseCase>(),
          gh<_i297.CheckAppStateUseCase>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i906.InjectableModule {}
