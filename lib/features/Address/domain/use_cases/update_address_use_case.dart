import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';
import 'package:supermarket/features/Address/domain/repositories/address_repository.dart';

@lazySingleton
class UpdateAddressUseCase implements UseCase<UpdateAddressParams, Address> {
  final AddressRepository _repository;

  const UpdateAddressUseCase(this._repository);

  @override
  FutureOrEitherFailureOrData<Address> call(UpdateAddressParams params) async {
    return await _repository.updateAddress(params);
  }
}

class UpdateAddressParams extends Equatable {
  final int id;
  final AddressRequest address;

  const UpdateAddressParams({required this.id, required this.address});

  @override
  List<Object?> get props => [id, address];
}
