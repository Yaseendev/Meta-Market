import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Product/data/data_sources/remote/product_remote_data_source.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl
    with BaseRepositoryImpl
    implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<List<Product>> getProducts(
      GetProductsParams params) async {
    return await request(() async {
      final products = await _productRemoteDataSource.fetchProducts();
      return Right(products.map((p) => p.toDomain()).toList());
    });
  }
}
