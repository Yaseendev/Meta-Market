import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/data/models/product_image/product_image_model.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductModel {
  final int id;
  final String name;
  final num price;
  final String? image;
  final String? description;
  final String? brand;
  final List<ProductImageModel>? images;
  final num? rating;
  final bool? isDeal;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.brand,
    this.description,
    this.images,
    this.isDeal,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Product toDomain() => Product(
    id: id,
    name: name,
    image: image,
    price: price,
    brand: brand,
    description: description,
    images: images?.map((i) => i.toDomain()).toList(),
    isDeal: isDeal,
    rating: rating,
  );
}
