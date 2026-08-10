import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Address/data/data_sources/remote/address_remote_data_source.dart';
import 'package:supermarket/features/Address/data/mappers/address_request_model_mapper.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';
import 'package:supermarket/features/Address/domain/repositories/address_repository.dart';
import 'package:supermarket/features/Address/domain/use_cases/update_address_use_case.dart';

@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl
    with BaseRepositoryImpl
    implements AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;

  AddressRepositoryImpl(this._remoteDataSource);

  @override
  FutureOrEitherFailureOrData<List<Address>> getAddresses() async {
    return await request(() async {
      final addresses = await _remoteDataSource.getAddresses();

      return Right(addresses.map((a) => a.toDomain()).toList());
    });
  }

  @override
  FutureOrEitherFailureOrData<Address> addAddress(
    AddressRequest address,
  ) async {
    return await request(() async {
      final addressModel = await _remoteDataSource.createAddress(
        address.toModel(),
      );

      return Right(addressModel.toDomain());
    });
  }

  @override
  FutureOrEitherFailureOrData<Address> updateAddress(
    UpdateAddressParams params,
  ) async {
    return await request(() async {
      final addressModel = await _remoteDataSource.updateAddress(
        params.id,
        params.address.toModel(),
      );

      return Right(addressModel.toDomain());
    });
  }

  @override
  FutureOrEitherFailureOrData<Unit> removeAddress(int addressId) async {
    return await request(() async {
      await _remoteDataSource.deleteAddress(addressId);

      return const Right(unit);
    });
  }
}
