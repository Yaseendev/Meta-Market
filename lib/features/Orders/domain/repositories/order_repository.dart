import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Orders/domain/entities/create_order_request.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';

abstract class OrderRepository {
  const OrderRepository();

  FutureOrEitherFailureOrData<List<Order>> getOrders();
  FutureOrEitherFailureOrData<Order> createOrder(CreateOrderRequest request);
}
