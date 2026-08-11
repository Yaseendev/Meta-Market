import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Categories/domain/entities/filter_options.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<BaseState<ProductsState>> {
  final GetProductsUseCase _getProductsUseCase;
  ProductsCubit(this._getProductsUseCase) : super(const BaseState.init());

  void getProducts({
    int? categoryId,
    String? searchTerm,
    FilterOptions? filterOptions,
  }) async {
    final term = (searchTerm?.isEmpty ?? true)
        ? (state.item?.searchTerm?.isEmpty ?? true)
              ? null
              : state.item?.searchTerm
        : searchTerm;
    final filter = filterOptions ?? state.item?.filterOptions;
    emit(
      state.copyWith(
        status: BaseStatus.loading,
        item: ProductsState(
          selectedCategory: categoryId ?? state.item?.selectedCategory,
          searchTerm: term,
          filterOptions: filter,
        ),
      ),
    );
    final result = await _getProductsUseCase(
      GetProductsParams(
        category: categoryId,
        term: term,
        filterOptions: filter,
      ),
    );
    result.fold(
      (f) {
        emit(state.setFailureState(f));
      },
      (p) {
        emit(
          state.setSuccessState(
            ProductsState(
              selectedCategory: categoryId,
              products: p.products,
              isFirstPage: p.isFirstPage,
              isLastPage: p.isLastPage,
              page: p.page,
              searchTerm: term,
              filterOptions: filter,
            ),
          ),
        );
      },
    );
  }

  void getNextProducts() async {
    if (state.item?.isLastPage ?? false) return;
    emit(state.copyWith(status: BaseStatus.loading));
    final result = await _getProductsUseCase(
      GetProductsParams(
        category: state.item?.selectedCategory,
        page: (state.item?.page ?? 0) + 1,
        term: state.item?.searchTerm,
      ),
    );
    result.fold(
      (f) {
        emit(state.copyWith(status: BaseStatus.failure, failure: f));
      },
      (p) {
        final products = List<Product>.of(state.item?.products ?? []);
        products.addAll(p.products);
        emit(
          state.setSuccessState(
            ProductsState(
              selectedCategory: state.item?.selectedCategory,
              products: products,
              isFirstPage: p.isFirstPage,
              isLastPage: p.isLastPage,
              page: p.page,
              searchTerm: state.item?.searchTerm,
              filterOptions: state.item?.filterOptions,
            ),
          ),
        );
      },
    );
  }
}
