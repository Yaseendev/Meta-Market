import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';
import 'package:supermarket/features/Address/domain/use_cases/update_address_use_case.dart';

abstract class AddressRepository {
  const AddressRepository();

  FutureOrEitherFailureOrData<List<Address>> getAddresses();
  FutureOrEitherFailureOrData<Address> addAddress(AddressRequest address);
  FutureOrEitherFailureOrData<Address> updateAddress(
    UpdateAddressParams params,
  );
  FutureOrEitherFailureOrData<Unit> removeAddress(int addressId);
}
