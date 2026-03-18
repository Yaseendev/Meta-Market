import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/errors/auth_token_failure.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart';
import 'package:supermarket/features/User/data/datasources/user_local_datasource.dart';
import 'package:supermarket/features/User/data/models/app_user_model.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl with BaseRepositoryImpl implements AuthRepository {
  final UserLocalDataSource userLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.userLocalDataSource,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> checkUser() async {
    return await request(
      () async {
        final String? authToken = await userLocalDataSource.getToken();
        if (authToken == null)
          return Left(AuthTokenFailure(message: 'No Token'));
        await authRemoteDataSource.checkToken(authToken);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, AppUserModel>> login(
      String email, String password) async {
    return await request(
      () async {
        final result = await authRemoteDataSource.login(email, password);
        await userLocalDataSource.saveToken(result['token']);
        return Right(AppUserModel.fromMap(result['user']));
      },
    );
  }

  @override
  Future<Either<Failure, AppUser>> signup(
      String email, String password, NameModel name, String phoneNumber) async {
    return await request(
      () async {
        final result = await authRemoteDataSource.signup(
            email, password, name, phoneNumber);
        await userLocalDataSource.saveToken(result['token']);
        return Right(AppUserModel.fromMap(result['user']));
      },
    );
  }

  @override
  Future<Either<Failure, AppUser>> authWithGoogle() async {
    return await request(
      () async {
        final googleAcount = await authRemoteDataSource.signInGoogle();
        if (googleAcount == null)
          return Left(Failure(message: 'Something went wrong'));
        final gAuth = await googleAcount.authentication;
        if (gAuth.accessToken == null)
          return Left(Failure(message: 'Something went wrong'));
        final result = await authRemoteDataSource.authWithGoogle(
            gAuth.accessToken ?? '',
            NameModel.fromFullName(googleAcount.displayName ?? ''));
        await userLocalDataSource.saveToken(result['token']);
        return Right(AppUserModel.fromMap(result['user']));
      },
    );
  }
}
