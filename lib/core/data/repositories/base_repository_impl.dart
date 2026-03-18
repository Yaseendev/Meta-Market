import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/domain/repositories/base_repository.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/errors/auth_token_failure.dart';
import 'package:supermarket/core/errors/exceptions.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/core/errors/no_connection_failure.dart';
import 'package:supermarket/core/errors/server_failure.dart';
import 'package:supermarket/core/services/connection_checker.dart';

mixin BaseRepositoryImpl implements BaseRepository {
  final ConnectionChecker connectionChecker = getIt<ConnectionChecker>();
  @override
  FutureOr<Either<Failure, T>> request<T>(
      FutureEitherFailureOrDataCallback<T> body) async {
    try {
      if (await connectionChecker.isConnected) {
        return await body();
      }
      return Left(
          NoInternetConnectionFailure(message: 'No Internet Connection'));
    } on AuthTokenException {
      return Left(AuthTokenFailure(message: 'Token Invalid'));
    } on DioException catch (err) {
      return Left(ServerFailure.formDioException(err));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
