import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';

part 'product_remote_data_source.g.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({int? categoryId});
}

@LazySingleton(as: ProductRemoteDataSource)
@RestApi()
abstract class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @factoryMethod
  factory ProductRemoteDataSourceImpl(Dio dio) {
    return _ProductRemoteDataSourceImpl(dio);
  }

  @override
  @POST(Urls.SEARCH_PRODUCTS)
  Future<List<ProductModel>> fetchProducts({int? categoryId});
}
