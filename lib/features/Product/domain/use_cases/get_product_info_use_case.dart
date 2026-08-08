import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart';

@lazySingleton
class GetProductInfoUseCase implements UseCase<String, ProductResponse> {
  final ProductRepository _productRepository;

  const GetProductInfoUseCase(this._productRepository);

  @override
  FutureOrEitherFailureOrData<ProductResponse> call(String id) async {
    return await _productRepository.getProduct(id);
  }
}
