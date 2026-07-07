import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Categories/data/data_sources/remote/categories_remote_data_source.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';
import 'package:supermarket/features/Categories/domain/repositories/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl
    with BaseRepositoryImpl
    implements CategoryRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;

  CategoryRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<List<Category>> getCategories() async {
    return await request(() async {
      final categories = await _categoriesRemoteDataSource.getCategories();

      return Right(categories.map((c) => c.toDomain()).toList());
    });
  }
}
