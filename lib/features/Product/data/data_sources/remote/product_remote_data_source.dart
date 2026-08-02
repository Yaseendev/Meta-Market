import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Product/data/models/product_response/product_response_model.dart';
import 'package:supermarket/features/Product/data/models/products_response/products_response_model.dart';

part 'product_remote_data_source.g.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> fetchProducts({
    int? categoryId,
    String? keyword,
    int? limit,
    String? barcode,
  });
  Future<ProductResponseModel> getProduct({required int id});
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
  Future<ProductsResponseModel> fetchProducts({
    @Field('category_id') int? categoryId,
    @Field() String? keyword,
    @Field('size') int? limit,
    @Field() String? barcode,
  });

  @override
  @GET('${Urls.PRODUCT_PATH}/{id}')
  Future<ProductResponseModel> getProduct({@Path() required int id});
}
