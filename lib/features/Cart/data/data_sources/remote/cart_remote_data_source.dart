import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Cart/data/models/cart_item_model.dart';

part 'cart_remote_data_source.g.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<CartItemModel> addItem({required int productId, int quantity = 1});
  Future<dynamic> updateItem({required int productId, required int quantity});
  Future<dynamic> removeItem(int itemId);
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

  @override
  @POST(Urls.ADD_ITEM)
  Future<CartItemModel> addItem({
    @Field('product_id') required int productId,
    @Field() int quantity = 1,
  });

  @override
  @PUT(Urls.ADD_ITEM)
  Future<dynamic> updateItem({
    @Field('product_id') required int productId,
    @Field() required int quantity,
  });

  @override
  @DELETE('${Urls.REMOVE_ITEM}/{itemId}')
  Future<dynamic> removeItem(@Path('itemId') int itemId);
}
