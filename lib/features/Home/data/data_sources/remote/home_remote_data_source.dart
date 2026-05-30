import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';

part 'home_remote_data_source.g.dart';

abstract class HomeRemoteDataSource {
  //TODO: Check
  Future<dynamic> getHomeData();
}

@LazySingleton(as: HomeRemoteDataSource)
@RestApi()
abstract class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @factoryMethod
  factory HomeRemoteDataSourceImpl(Dio dio) {
    return _HomeRemoteDataSourceImpl(dio);
  }

  @override
  @GET(Urls.HOME)
  Future<dynamic> getHomeData();
}
