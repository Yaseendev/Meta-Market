import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart';

@lazySingleton
class GetProductsUseCase implements UseCase<GetProductsParams, List<Product>> {
  final ProductRepository _productRepository;

  const GetProductsUseCase(this._productRepository);

  @override
  FutureOrEitherFailureOrData<List<Product>> call(
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

  const GetProductsParams({this.category, this.term, this.limit, this.barcode});

  @override
  List<Object?> get props => [category, term, limit, barcode];
}
