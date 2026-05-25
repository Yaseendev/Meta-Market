import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:supermarket/features/Home/data/models/home_data_model.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl with BaseRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<HomeData> getHomeData() async {
    return await request(() async {
      final result = await homeRemoteDataSource.getHomeData();
      final data = HomeDataModel.fromJson(result);
      return Right(data.toDomain());
    });
  }
}
