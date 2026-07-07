import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

abstract class CategoryRepository {
  FutureOrEitherFailureOrData<List<Category>> getCategories();
}
