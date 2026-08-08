import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';

part 'product_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductResponseModel {
  final ProductModel product;
  @JsonKey(name: 'availableStock')
  final int stock;
  final List<ProductModel> relatedProducts;

  const ProductResponseModel({
    required this.product,
    required this.stock,
    required this.relatedProducts,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);

  ProductResponse toDomain() => ProductResponse(
    product: product.toDomain(),
    stock: stock,
    relatedProducts: relatedProducts.map((pr) => pr.toDomain()).toList(),
  );
}
