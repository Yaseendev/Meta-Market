import 'package:dartz/dartz.dart';
import 'package:supermarket/core/errors/auth_token_failure.dart';
import 'package:supermarket/core/errors/exceptions.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/core/errors/no_connection_failure.dart';
import 'package:supermarket/core/errors/server_failure.dart';
import 'package:supermarket/core/services/connection_checker.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final ConnectionChecker connectionChecker;

  const UserRepositoryImpl({
    required this.userLocalDataSource,
    required this.userRemoteDataSource,
    required this.connectionChecker,
  });

}
