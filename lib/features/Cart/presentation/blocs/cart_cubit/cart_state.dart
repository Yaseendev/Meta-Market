part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final DeliveryOption? deliveryOption;
  final bool isCheckingOut;

  const CartState({
    required this.items,
    this.deliveryOption,
    this.isCheckingOut = false,
  });

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.total);

  double get total =>
      subtotal + (deliveryOption == DeliveryOption.delivery ? 10 : 0);

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
    DeliveryOption? deliveryOption,
    bool? isCheckOut,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      isCheckingOut: isCheckOut ?? this.isCheckingOut,
    );
  }

  @override
  List<Object?> get props => [items, deliveryOption, isCheckingOut];
}
