import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/errors/failure.dart';

abstract class BaseRepository {
  FutureOr<Either<Failure, T>> request<T>(
      FutureEitherFailureOrDataCallback<T> body);
}
