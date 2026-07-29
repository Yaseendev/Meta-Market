import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';
import 'package:supermarket/features/Product/domain/entities/products_response.dart';

part 'products_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductsResponseModel {
  @JsonKey(name: 'content')
  final List<ProductModel> products;
  final int totalPages;
  @JsonKey(name: 'totalElements')
  final int totalItems;
  @JsonKey(name: 'last')
  final bool isLastPage;
  @JsonKey(name: 'first')
  final bool isFirstPage;
  @JsonKey(name: 'size')
  final int pageSize;
  @JsonKey(name: 'number')
  final int page;

  const ProductsResponseModel({
    required this.products,
    required this.totalPages,
    required this.totalItems,
    required this.isLastPage,
    required this.isFirstPage,
    required this.pageSize,
    required this.page,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  ProductsResponse toDomain() => ProductsResponse(
    products: products.map((p) => p.toDomain()).toList(),
    totalPages: totalPages,
    totalItems: totalItems,
    isLastPage: isLastPage,
    isFirstPage: isFirstPage,
    pageSize: pageSize,
    page: page,
  );
}
