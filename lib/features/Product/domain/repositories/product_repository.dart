import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';
import 'package:supermarket/features/Product/domain/entities/products_response.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

abstract class ProductRepository {
  const ProductRepository();
  FutureOrEitherFailureOrData<ProductsResponse> getProducts(
    GetProductsParams params,
  );
  FutureOrEitherFailureOrData<ProductResponse> getProduct(String id);
}
