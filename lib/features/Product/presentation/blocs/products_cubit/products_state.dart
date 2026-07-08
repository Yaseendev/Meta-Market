part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final int? selectedCategory;
  final List<Product> products;
  const ProductsState({
    required this.products,
    this.selectedCategory,
  });

  ProductsState copyWith({
    int? selectedCategory,
    List<Product>? products,
  }) {
    return ProductsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, products];

}
