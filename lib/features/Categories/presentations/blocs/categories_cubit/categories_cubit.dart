import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

@injectable
class CategoriesCubit extends Cubit<BaseState<List<Category>>> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  CategoriesCubit(this._getCategoriesUseCase) : super(const BaseState.init());

  void getCategories() async {
    emit(state.setInProgressState());
    final result = await _getCategoriesUseCase();
  }
}
