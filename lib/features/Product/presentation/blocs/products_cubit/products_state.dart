part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final int? selectedCategory;
  final List<Product>? products;
  final bool? isLastPage;
  final bool? isFirstPage;
  final int? page;
  final String? searchTerm;
  final FilterOptions? filterOptions;
  const ProductsState({
    this.products,
    this.selectedCategory,
    this.isLastPage,
    this.isFirstPage,
    this.page,
    this.searchTerm,
    this.filterOptions,
  });

  ProductsState copyWith({
    int? selectedCategory,
    List<Product>? products,
    bool? isLastPage,
    bool? isFirstPage,
    int? page,
    bool? isLoadingMore,
    FilterOptions? filterOptions,
  }) {
    return ProductsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      products: products ?? this.products,
      isFirstPage: isFirstPage ?? this.isFirstPage,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
      searchTerm: this.searchTerm,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    products,
    isFirstPage,
    isLastPage,
    page,
    searchTerm,
    filterOptions,
  ];
}
