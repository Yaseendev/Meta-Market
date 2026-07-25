import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/usecases/update_item_use_case.dart';

abstract class CartRepository {
  const CartRepository();

  FutureOrEitherFailureOrData<List<CartItem>> getCart();
  FutureOrEitherFailureOrData<CartItem> addItem(int productId);
  FutureOrEitherFailureOrData<Unit> updateItem(UpdateItemParams params);
  FutureOrEitherFailureOrData<Unit> removeItem(int itemId);
}
