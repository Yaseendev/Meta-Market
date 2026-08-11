import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Categories/domain/entities/filter_options.dart';
import 'package:supermarket/features/Product/domain/entities/products_response.dart';
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart';

@lazySingleton
class GetProductsUseCase
    implements UseCase<GetProductsParams, ProductsResponse> {
  final ProductRepository _productRepository;

  const GetProductsUseCase(this._productRepository);

  @override
  FutureOrEitherFailureOrData<ProductsResponse> call(
    GetProductsParams params,
  ) async {
    return await _productRepository.getProducts(params);
  }
}

class GetProductsParams extends Equatable {
  final int? category;
  final String? term;
  final int? limit;
  final String? barcode;
  final int? page;
  final FilterOptions? filterOptions;

  const GetProductsParams({
    this.category,
    this.term,
    this.limit,
    this.barcode,
    this.page,
    this.filterOptions,
  });

  @override
  List<Object?> get props => [category, term, limit, barcode, page, filterOptions];
}
