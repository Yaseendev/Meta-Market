import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class ProductsResponse extends Equatable {
  final List<Product> products; //content
  final int totalPages;
  final int totalItems;
  final bool isLastPage;
  final bool isFirstPage;
  final int pageSize;
  final int page;

  const ProductsResponse({
    required this.products,
    required this.totalPages,
    required this.totalItems,
    required this.isLastPage,
    required this.isFirstPage,
    required this.pageSize,
    required this.page,
  });

  @override
  List<Object?> get props => [
    products,
    totalItems,
    totalPages,
    isFirstPage,
    isLastPage,
    pageSize,
    page,
  ];
}
