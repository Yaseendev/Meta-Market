import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';

@lazySingleton
class RemoveItemUseCase implements UseCase<int, Unit> {
  final CartRepository _cartRepository;

  const RemoveItemUseCase(this._cartRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call(int itemId) async {
    return await _cartRepository.removeItem(itemId);
  }
}
