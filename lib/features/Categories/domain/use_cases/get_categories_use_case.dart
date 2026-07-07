import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';
import 'package:supermarket/features/Categories/domain/repositories/category_repository.dart';

@lazySingleton
class GetCategoriesUseCase implements UseCase<NoParams, List<Category>> {
  final CategoryRepository _categoryRepository;

  const GetCategoriesUseCase(this._categoryRepository);

  @override
  FutureOrEitherFailureOrData<List<Category>> call([NoParams? params]) async {
    return await _categoryRepository.getCategories();
  }
}
