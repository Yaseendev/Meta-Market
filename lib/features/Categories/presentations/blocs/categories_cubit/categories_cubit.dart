import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';
import 'package:supermarket/features/Categories/domain/use_cases/get_categories_use_case.dart';

@injectable
class CategoriesCubit extends Cubit<BaseState<List<Category>>> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  CategoriesCubit(this._getCategoriesUseCase) : super(const BaseState.init());

  void getCategories() async {
    emit(state.setLoadingState());
    final result = await _getCategoriesUseCase();
    result.fold(
      (f) {
        emit(state.setFailureState(f));
      },
      (c) {
        emit(state.setSuccessState(c));
      },
    );
  }
}
