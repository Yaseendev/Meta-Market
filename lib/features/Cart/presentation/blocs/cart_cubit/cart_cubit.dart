import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Cart/domain/usecases/add_item_use_case.dart';
import 'package:supermarket/features/Cart/domain/usecases/get_cart_use_case.dart';
import 'package:supermarket/features/Cart/domain/usecases/remove_item_use_case.dart';
import 'package:supermarket/features/Cart/domain/usecases/update_item_use_case.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<BaseState<CartState>> {
  final GetCartUseCase _getCartUseCase;
  final AddItemUseCase _addItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;
  final RemoveItemUseCase _removeItemUseCase;

  CartCubit(
    this._getCartUseCase,
    this._addItemUseCase,
    this._updateItemUseCase,
    this._removeItemUseCase,
  ) : super(const BaseState.init());

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

  void increaseQuantity(int itemId) async {
    final tempItems = state.item?.items ?? [];
    CartItem? item;
    final items = tempItems.map((currentItem) {
      if (currentItem.id == itemId) {
        return item = currentItem.copyWith(quantity: currentItem.quantity + 1);
      }

      return currentItem;
    }).toList();

    emit(state.copyWith(item: state.item?.copyWith(items: items)));
    if (item != null) {
      final result = await _updateItemUseCase(
        UpdateItemParams(
          productId: item!.product.id,
          quantity: item?.quantity ?? 1,
        ),
      );
      if (result.isLeft()) {
        // Rollback
        final revItems = tempItems.map((currentItem) {
          if (currentItem.id == itemId) {
            return currentItem.copyWith(quantity: currentItem.quantity - 1);
          }

          return currentItem;
        }).toList();

        emit(state.copyWith(item: state.item?.copyWith(items: revItems)));
      }
    }
  }

  void decreaseQuantity(int itemId) async {
    final tempItems = state.item?.items ?? [];
    final items = List<CartItem>.from(state.item?.items ?? []);
    final itemIndex = items.indexWhere((t) => t.id == itemId);
    if (itemIndex == -1) return;
    CartItem item = items[itemIndex];
    if (item.quantity > 1) {
      items[itemIndex] = item.copyWith(quantity: item.quantity - 1);
    } else {
      items.removeAt(itemIndex);
    }

    emit(state.copyWith(item: state.item?.copyWith(items: items)));

    final result = item.quantity > 1
        ? await _updateItemUseCase(
            UpdateItemParams(
              productId: item.product.id,
              quantity: item.quantity - 1,
            ),
          )
        : await _removeItemUseCase(itemId);
    if (result.isLeft()) {
      // Rollback

      emit(state.copyWith(item: state.item?.copyWith(items: tempItems)));
    }
  }

  void removeItem(int itemId) async {
    final items = List<CartItem>.from(state.item?.items ?? []);
    emit(
      state.copyWith(
        item: state.item?.copyWith(
          items: state.item?.items.where((e) => e.id != itemId).toList(),
        ),
      ),
    );
    final result = await _removeItemUseCase(itemId);
    if (result.isLeft()) {
      emit(state.copyWith(item: state.item?.copyWith(items: items)));
    }
  }

  void changeDeliveryOption(DeliveryOption option) {
    emit(state.copyWith(item: state.item?.copyWith(deliveryOption: option)));
  }
}
