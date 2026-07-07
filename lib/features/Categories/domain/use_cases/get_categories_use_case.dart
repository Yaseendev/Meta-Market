import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

@lazySingleton
class GetCategoriesUseCase implements UseCase<NoParams, List<Category>> {
  final CategoryRepository _categoryRepository;
}
