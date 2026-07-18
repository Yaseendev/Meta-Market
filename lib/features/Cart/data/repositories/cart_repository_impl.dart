import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Cart/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';
import 'package:supermarket/features/Cart/domain/repositories/cart_repository.dart';

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
}
