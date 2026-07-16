import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<BaseState<CartState>> {
  final GetCartUseCase _getCartUseCase;
  CartCubit(this._getCartUseCase) : super(const BaseState.init());
}
