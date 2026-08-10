import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';
import 'package:supermarket/features/Address/domain/repositories/address_repository.dart';

@lazySingleton
class AddAddressUseCase implements UseCase<AddressRequest, Address> {
  final AddressRepository _repository;

  const AddAddressUseCase(this._repository);

  @override
  FutureOrEitherFailureOrData<Address> call(AddressRequest params) async {
    return await _repository.addAddress(params);
  }
}
