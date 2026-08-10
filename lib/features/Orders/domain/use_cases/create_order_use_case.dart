import 'package:injectable/injectable.dart' hide Order;
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Orders/domain/entities/create_order_request.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/repositories/order_repository.dart';

@lazySingleton
class CreateOrderUseCase implements UseCase<CreateOrderRequest, Order> {
  final OrderRepository _orderRepository;

  const CreateOrderUseCase(this._orderRepository);

  @override
  FutureOrEitherFailureOrData<Order> call(CreateOrderRequest params) async {
    return await _orderRepository.createOrder(params);
  }
}