import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';

@lazySingleton
class GetCartUseCase implements UseCase<NoParams, List<CartItem>> {
  final CartRepository _cartRepository;

  const GetCartUseCase(this._cartRepository);

  @override
  FutureOrEitherFailureOrData<List<CartItem>> call([NoParams? params]) async {
    return await _cartRepository.getCart();
  }
}