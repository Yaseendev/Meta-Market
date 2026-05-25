import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductModel {
  final int id;
  final String name;
  final num price;
  final String? image;

  const ProductModel(
      {required this.id, required this.name, required this.price, this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Product toDomain() => Product(
        id: id,
        name: name,
        image: image,
        price: price,
      );
}
