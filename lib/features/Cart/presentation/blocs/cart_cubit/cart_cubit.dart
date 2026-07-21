import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/usecases/add_item_use_case.dart';
import 'package:supermarket/features/Cart/domain/usecases/get_cart_use_case.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<BaseState<CartState>> {
  final GetCartUseCase _getCartUseCase;
  final AddItemUseCase _addItemUseCase;
  CartCubit(this._getCartUseCase, this._addItemUseCase)
    : super(const BaseState.init());

  void getCart() async {
    emit(const BaseState.loading());
    final result = await _getCartUseCase();
    result.fold(
      (f) {
        emit(BaseState.error(fail: f));
      },
      (r) {
        emit(state.setSuccessState(CartState(items: r)));
      },
    );
  }

  void addItem(Product product) async {
    final items = List<CartItem>.from(state.item?.items ?? []);
    final loadingItems = List<CartItem>.from(state.tempItem?.items ?? []);
    if (!loadingItems.any((t) => t.product.id == product.id)) {
      loadingItems.add(
        CartItem(
          id: product.id,
          product: product,
          quantity: 1,
          total: product.price,
        ),
      );
    }
    emit(
      state.copyWith(
        status: BaseStatus.loading,
        tempItem: state.tempItem?.copyWith(items: loadingItems),
      ),
    );

    // final index = items.indexWhere((e) => e.product.id == product.id);

    // if (index != -1) {
    //   items[index] = items[index].copyWith(
    //     quantity: items[index].quantity + 1,
    //   );
    // } else {
    //   items.add(event.item);
    // }

    // emit(state.copyWith(items: items));
    final result = await _addItemUseCase(product.id);
    loadingItems.removeWhere((t) => t.product.id == product.id);
    result.fold(
      (f) {
        emit(
          state.copyWith(
            status: BaseStatus.failure,
            item: state.item?.copyWith(items: items),
            failure: f,
            tempItem: state.tempItem?.copyWith(items: loadingItems),
          ),
        );
      },
      (item) {
        items.add(item);
        emit(
          state.copyWith(
            item: state.item?.copyWith(items: items),
            status: BaseStatus.success,
            tempItem: state.tempItem?.copyWith(items: loadingItems),
          ),
        );
      },
    );
  }
}
