import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';

@lazySingleton
class AddItemUseCase implements UseCase<int, CartItem> {
  final CartRepository _repository;

  const AddItemUseCase(this._repository);

  @override
  FutureOrEitherFailureOrData<CartItem> call(int params) async {
    return _repository.addItem(params);
  }
}
