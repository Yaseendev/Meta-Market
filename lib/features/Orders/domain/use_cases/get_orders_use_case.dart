import 'package:injectable/injectable.dart' hide Order;
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/repositories/order_repository.dart';

@lazySingleton
class GetOrdersUseCase implements UseCase<NoParams, List<Order>> {
  final OrderRepository _orderRepository;

  const GetOrdersUseCase(this._orderRepository);

  @override
  FutureOrEitherFailureOrData<List<Order>> call([NoParams? params]) async {
    return await _orderRepository.getOrders();
  }
}
