import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';

@lazySingleton
class UpdateItemUseCase implements UseCase<UpdateItemParams, Unit> {
  final CartRepository _cartRepository;

  const UpdateItemUseCase(this._cartRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call(UpdateItemParams params) async {
    return await _cartRepository.updateItem(params);
  }
}

class UpdateItemParams extends Equatable {
  final int productId;
  final int quantity;

  const UpdateItemParams({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}
