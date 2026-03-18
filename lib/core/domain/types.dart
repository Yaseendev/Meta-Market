import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supermarket/core/errors/failure.dart';

typedef FutureOrEitherFailureOrData<T> = FutureOr<Either<Failure, T>>;
typedef FutureEitherFailureOrDataCallback<T> = FutureOrEitherFailureOrData<T>
    Function();
typedef Future<Unit> FutureVoid();