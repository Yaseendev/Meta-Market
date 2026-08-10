import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Orders/data/data_sources/remote/orders_remote_data_source.dart';
import 'package:supermarket/features/Orders/domain/entities/create_order_request.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/repositories/order_repository.dart';
import 'package:supermarket/features/Orders/data/mappers/order_request_model_mapper.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl with BaseRepositoryImpl implements OrderRepository {
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  OrderRepositoryImpl(this._ordersRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<List<Order>> getOrders() async {
    return await request(() async {
      final orders = await _ordersRemoteDataSource.getOrders();

      return Right(orders.map((o) => o.toDomain()).toList());
    });
  }

  @override
  FutureOrEitherFailureOrData<Order> createOrder(
    CreateOrderRequest orderRequest,
  ) async {
    return await request(() async {
      final order = await _ordersRemoteDataSource.createOrder(
        orderRequest.toModel(),
      );

      return Right(order.toDomain());
    });
  }
}
