import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class CartItem extends Equatable {
  final int id;
  final Product product;
  final int quantity;
  final num total;

  const CartItem(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.total});

  @override
  List<Object?> get props => [id, quantity, total];
}
