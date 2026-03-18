import 'package:dio/dio.dart';
import 'package:supermarket/core/config/constants/urls.dart';

abstract class UserRemoteDataSource {

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dioClient;

  const UserRemoteDataSourceImpl({required this.dioClient});

}
