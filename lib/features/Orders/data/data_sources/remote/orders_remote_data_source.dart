import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/features/Orders/data/models/create_order_request/create_order_request_model.dart';
import 'package:supermarket/features/Orders/data/models/order/order_model.dart';

part 'orders_remote_data_source.g.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> createOrder(CreateOrderRequestModel request);
}

@LazySingleton(as: OrdersRemoteDataSource)
@RestApi()
abstract class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  @factoryMethod
  factory OrdersRemoteDataSourceImpl(Dio dio) => _OrdersRemoteDataSourceImpl(dio);


  @override
  @GET(Urls.ORDERS_PATH)
  Future<List<OrderModel>> getOrders();

  @override
  @POST(Urls.ORDERS_PATH)
  Future<OrderModel> createOrder(@Body() CreateOrderRequestModel request);

}
