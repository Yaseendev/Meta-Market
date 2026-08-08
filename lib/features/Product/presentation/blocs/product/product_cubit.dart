import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_product_info_use_case.dart';

@injectable
class ProductCubit extends Cubit<BaseState<ProductResponse>> {
  final GetProductInfoUseCase _getProductInfoUseCase;
  final String id;
  ProductCubit(@factoryParam this.id, this._getProductInfoUseCase)
    : super(const BaseState.init()) {
    getProductInfo();
  }

  void getProductInfo() async {
    emit(state.setLoadingState());
    final result = await _getProductInfoUseCase(id);
    result.fold((f) => emit(state.setFailureState(f)), (s) {
      emit(state.setSuccessState(s));
    });
  }
}
