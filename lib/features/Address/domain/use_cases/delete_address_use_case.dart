import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Address/domain/repositories/address_repository.dart';

@lazySingleton
class DeleteAddressUseCase implements UseCase<int, Unit> {
  final AddressRepository _addressRepository;

  const DeleteAddressUseCase(this._addressRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call(int param) async {
    return await _addressRepository.removeAddress(param);
  }
}
