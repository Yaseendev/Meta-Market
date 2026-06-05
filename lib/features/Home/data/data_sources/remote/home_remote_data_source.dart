import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Home/data/models/home_data/home_data_model.dart';

part 'home_remote_data_source.g.dart';

abstract class HomeRemoteDataSource {
  //TODO: Check
  Future<HomeDataModel> getHomeData();
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
  Future<HomeDataModel> getHomeData();
}
