import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/usecases/get_cart_use_case.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<BaseState<CartState>> {
  final GetCartUseCase _getCartUseCase;
  CartCubit(this._getCartUseCase) : super(const BaseState.init());

  void getCart() async {
    emit(const BaseState.loading());
    final result = await _getCartUseCase();
    result.fold((f) {
      emit(BaseState.error(fail: f));
    }, (r) {
      emit(state.setSuccessState(CartState(
        items: r,
      )));
    });
  }
}
