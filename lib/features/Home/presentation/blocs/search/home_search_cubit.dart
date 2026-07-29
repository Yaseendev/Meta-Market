import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

part 'home_search_state.dart';

@injectable
class HomeSearchCubit extends Cubit<List<Product>> {
  final GetProductsUseCase _searchProductsUseCase;
  HomeSearchCubit(this._searchProductsUseCase) : super([]);

  Future<void> searchProducts(String term) async {
    if (term.isNotEmpty) {
      final result = await _searchProductsUseCase(
        GetProductsParams(term: term),
      );
      final res = result.getOrElse(() => []);
      emit(res);
    } else {
      emit([]);
    }
  }
}
