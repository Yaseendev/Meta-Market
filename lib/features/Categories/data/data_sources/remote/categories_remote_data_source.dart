import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Categories/data/models/category/category_model.dart';

part 'categories_remote_data_source.g.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

@LazySingleton(as: CategoriesRemoteDataSource)
@RestApi()
abstract class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSource {
  @factoryMethod
  factory CategoriesRemoteDataSourceImpl(Dio dio) {
    return _CategoriesRemoteDataSourceImpl(dio);
  }

  @override
  @GET(Urls.GET_CATEGORIES)
  Future<List<CategoryModel>> getCategories();
}
