import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<BaseState<ProductsState>> {
  final GetProductsUseCase _getProductsUseCase;
  ProductsCubit(this._getProductsUseCase) : super(const BaseState.init());

  void getProducts({int? category}) async {
    emit(state.setInProgressState());
  }
}
