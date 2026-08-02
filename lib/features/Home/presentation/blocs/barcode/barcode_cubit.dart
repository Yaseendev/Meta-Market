import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/errors/product_not_found_failure.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Product/domain/use_cases/get_products_use_case.dart';

part 'barcode_state.dart';

@injectable
class BarcodeCubit extends Cubit<BaseState<int>> {
  final GetProductsUseCase _searchBarcodeUseCase;
  BarcodeCubit(this._searchBarcodeUseCase) : super(const BaseState.init());

  void searchBarcode(String code) async {
    emit(state.setLoadingState());
    final result = await _searchBarcodeUseCase(
      GetProductsParams(barcode: code, limit: 1),
    );

    result.fold(
      (l) {
        emit(state.setFailureState(l));
      },
      (r) {
        if (r.isEmpty) {
          emit(
            state.setFailureState(
              ProductNotFoundFailure(message: LocaleKeys.productNotFound),
            ),
          );
        } else {
          emit(state.setSuccessState(r.first.id));
        }
      },
    );
  }
}
