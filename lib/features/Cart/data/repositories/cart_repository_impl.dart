import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Cart/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';
import 'package:supermarket/features/Cart/domain/usecases/update_item_use_case.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl with BaseRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  CartRepositoryImpl(this._cartRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<List<CartItem>> getCart() async {
    return await request(() async {
      final cartItems = await _cartRemoteDataSource.getCartItems();
      return Right(cartItems.map((c) => c.toDomain()).toList());
    });
  }

  @override
  FutureOrEitherFailureOrData<CartItem> addItem(int productId) async {
    return await request(() async {
      final cartItem = await _cartRemoteDataSource.addItem(
        productId: productId,
      );
      return Right(cartItem.toDomain());
    });
  }

  @override
  FutureOrEitherFailureOrData<Unit> updateItem(UpdateItemParams params) async {
    return await request(() async {
      await _cartRemoteDataSource.updateItem(
        productId: params.productId,
        quantity: params.quantity,
      );
      return const Right(unit);
    });
  }

  @override
  FutureOrEitherFailureOrData<Unit> removeItem(int itemId) async {
    return await request(() async {
      await _cartRemoteDataSource.removeItem(itemId);
      return const Right(unit);
    });
  }
}
