import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/use_cases/get_orders_use_case.dart';

@injectable
class OrdersCubit extends Cubit<BaseState<List<Order>>> {
  final GetOrdersUseCase _getOrdersUseCase;
  OrdersCubit(this._getOrdersUseCase) : super(const BaseState.init());

  Future<void> getOrders() async {
    emit(state.setLoadingState());
    final result = await _getOrdersUseCase();

    result.fold(
      (f) {
        emit(state.setFailureState(f));
      },
      (items) {
        emit(state.setSuccessState(items));
      },
    );
  }
}
