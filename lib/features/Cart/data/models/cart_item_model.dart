import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable(createToJson: false)
class CartItemModel {
  @JsonKey(name: 'itemId')
  final int id;
  final ProductModel product;
  final int quantity;
  final num total;

  const CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.total,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  CartItem toDomain() => CartItem(
    id: id,
    product: product.toDomain(),
    quantity: quantity,
    total: total,
  );
}
