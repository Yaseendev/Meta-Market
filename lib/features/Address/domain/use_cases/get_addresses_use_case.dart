import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/repositories/address_repository.dart';

@lazySingleton
class GetAddressesUseCase implements UseCase<NoParams, List<Address>> {
  final AddressRepository _addressRepository;

  const GetAddressesUseCase(this._addressRepository);

  @override
  FutureOrEitherFailureOrData<List<Address>> call([NoParams? params]) async {
    return await _addressRepository.getAddresses();
  }
}
