import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class ProductResponse extends Equatable {
  final Product product;
  final int stock;
  final List<Product> relatedProducts;

  ProductResponse({
    required this.product,
    required this.stock,
    required this.relatedProducts,
  });

  @override
  List<Object?> get props => [product, stock, relatedProducts];
}
