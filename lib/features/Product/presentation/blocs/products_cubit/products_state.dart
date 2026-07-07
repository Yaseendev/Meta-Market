part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final int? selectedCategory;
  final List<Product> products;
  const ProductsState({
    required this.products,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [selectedCategory, products];
}
