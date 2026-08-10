import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/mappers/address_param_mapper.dart';
import 'package:supermarket/features/Address/domain/use_cases/delete_address_use_case.dart';
import 'package:supermarket/features/Address/domain/use_cases/get_addresses_use_case.dart';
import 'package:supermarket/features/Address/domain/use_cases/update_address_use_case.dart';

part 'addresses_event.dart';

@injectable
class AddressesBloc extends Bloc<AddressesEvent, BaseState<List<Address>>> {
  final GetAddressesUseCase _getAddressesUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  AddressesBloc(
    this._getAddressesUseCase,
    this._updateAddressUseCase,
    this._deleteAddressUseCase,
  ) : super(const BaseState.init()) {
    on<GetAddresses>((event, emit) async {
      emit(const BaseState.loading());
      final result = await _getAddressesUseCase();

      result.fold(
        (fail) {
          emit(BaseState.error(fail: fail));
        },
        (addresses) {
          emit(state.setSuccessState(addresses));
        },
      );
    });

    on<MarkAsCurrent>((event, emit) async {
      final newAddress = event.address.copyWith(isDefault: true);
      final newAddresses = _modifyAddress(newAddress);
      emit(state.setSuccessState(newAddresses));
      final result = await _updateAddressUseCase(
        UpdateAddressParams(
          id: event.address.id,
          address: newAddress.toRequest(),
        ),
      );
      if (result.isLeft()) {
        final address = event.address;
        final addresses = _modifyAddress(address);
        emit(state.setSuccessState(addresses));
      }
    });

    on<DeleteAddress>((event, emit) async {
      final addresses = List<Address>.of(state.item ?? []);
      final addressIndex = addresses.indexWhere(
        (a) => a.id == event.address.id,
      );
      addresses.removeAt(addressIndex);
      emit(state.setSuccessState(addresses));
      final result = await _deleteAddressUseCase(event.address.id);

      if (result.isLeft()) {
        addresses.insert(addressIndex, event.address);
        emit(state.setSuccessState(addresses));
      }
    });

    on<AddAddress>((event, emit) {
      final addresses = List<Address>.of(state.item ?? []);
      addresses.add(event.address);
      emit(state.setSuccessState(addresses));
    });

    on<UpdateAddress>((event, emit) {
      final newAddress = event.address;
      final newAddresses = _modifyAddress(newAddress);
      emit(state.setSuccessState(newAddresses));
    });
  }

  List<Address> _modifyAddress(Address address) {
    final addresses = List<Address>.of(state.item ?? []);
    final addressIndex = addresses.indexWhere((a) => a.id == address.id);
    if (addressIndex != -1) {
      addresses[addressIndex] = address;
    }
    return addresses;
  }

  String toJson() => '';
}
