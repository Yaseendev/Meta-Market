import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Categories/domain/enums/sort_type.dart';
import 'package:supermarket/features/Product/data/data_sources/remote/product_remote_data_source.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';
import 'package:supermarket/features/Product/domain/entities/products_response.dart';
import 'package:supermarket/features/Product/domain/repositories/product_repository.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl
    with BaseRepositoryImpl
    implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<ProductsResponse> getProducts(
    GetProductsParams params,
  ) async {
    return await request(() async {
      final isDeal = params.filterOptions?.isDeal == true ? true : null;
      final sort = params.filterOptions?.sortType == SortType.RELEVANCE
          ? null
          : params.filterOptions?.sortType?.name;
      final productsRes = await _productRemoteDataSource.fetchProducts(
        keyword: params.term,
        categoryId: params.category,
        limit: params.limit,
        page: params.page,
        isDeal: isDeal,
        maxPrice: params.filterOptions?.maxPrice,
        minPrice: params.filterOptions?.minPrice,
        sort: sort,
      );
      return Right(productsRes.toDomain());
    });
  }

  @override
  FutureOrEitherFailureOrData<ProductResponse> getProduct(String id) async {
    return await request(() async {
      final productRes = await _productRemoteDataSource.getProduct(id: id);
      return Right(productRes.toDomain());
    });
  }
}
