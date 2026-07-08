import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<BaseState<ProductsState>> {
  final GetProductsUseCase _getProductsUseCase;
  ProductsCubit(this._getProductsUseCase) : super(const BaseState.init());

  void getProducts({int? categoryId}) async {
    emit(state.copyWith(
      status: BaseStatus.inProgress,
      item: state.item?.copyWith(
        selectedCategory: categoryId,
      ),
    ));
    final result =
        await _getProductsUseCase(GetProductsParams(category: categoryId));
    result.fold((f) {
      emit(state.setFailureState(f));
    }, (p) {
      emit(state.setSuccessState(ProductsState(
        selectedCategory: categoryId,
        products: p,
      )));
    });
  }
}
