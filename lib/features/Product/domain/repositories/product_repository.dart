import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

abstract class ProductRepository {
  const ProductRepository();
  FutureOrEitherFailureOrData<List<Product>> getProducts(
      GetProductsParams params);
}
