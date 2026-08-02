import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/domain/entities/product_image.dart';

part 'product_image_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductImageModel {
  final int id;
  final String url;

  const ProductImageModel({required this.id, required this.url});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageModelFromJson(json);

  ProductImage toDomain() => ProductImage(id: id, url: url);
}
