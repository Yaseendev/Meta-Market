import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Cart/data/models/cart_item_model.dart';

part 'cart_remote_data_source.g.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems();
}

@LazySingleton(as: CartRemoteDataSource)
@RestApi()
abstract class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @factoryMethod
  factory CartRemoteDataSourceImpl(Dio dio) {
    return _CartRemoteDataSourceImpl(dio);
  }

  @override
  @GET(Urls.CART_PATH)
  Future<List<CartItemModel>> getCartItems();
}
