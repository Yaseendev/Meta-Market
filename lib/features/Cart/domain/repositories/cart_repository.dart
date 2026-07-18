import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  const CartRepository();

  FutureOrEitherFailureOrData<List<CartItem>> getCart();
}
