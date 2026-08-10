import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';
import 'package:supermarket/features/Address/domain/mappers/address_param_mapper.dart';
import 'package:supermarket/features/Address/domain/use_cases/add_address_use_case.dart';
import 'package:supermarket/features/Address/domain/use_cases/update_address_use_case.dart';

@injectable
class AddressCubit extends Cubit<BaseState<Address>> {
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  AddressRequest? _request;
  AddressCubit(this._addAddressUseCase, this._updateAddressUseCase)
    : super(const BaseState.init());

  void addAddress() async {
    if (_request != null) {
      emit(state.setLoadingState());
      final result = await _addAddressUseCase(_request!);
      result.fold(
        (l) {
          emit(state.setFailureState(l));
        },
        (address) {
          emit(state.setSuccessState(address));
        },
      );
    }
  }

  void updateAddress(int id) async {
    if (_request != null) {
      emit(state.setLoadingState());
      final result = await _updateAddressUseCase(
        UpdateAddressParams(id: id, address: _request!),
      );
      result.fold(
        (l) {
          emit(state.setFailureState(l));
        },
        (address) {
          emit(state.setSuccessState(address));
        },
      );
    }
  }

  void setAddress(Address? address) {
    _request = address?.toRequest();
  }

  bool get isLocationSet =>
      _request?.latitude != null && _request?.longitude != null;

  void setValues({
    String? city,
    String? state,
    String? street,
    String? blockNumber,
    String? floorNumber,
    String? phoneNumber,
    String? buildingName,
    String? apartmentNumber,
    String? additionalInfo,
    String? label,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) {
    _request = _request == null
        ? AddressRequest(
            city: city ?? '',
            phoneNumber: phoneNumber ?? '',
            label: label ?? '',
            additionalInfo: additionalInfo,
            apartmentNumber: apartmentNumber,
            blockNumber: blockNumber,
            buildingName: buildingName,
            floorNumber: floorNumber,
            isDefault: isDefault,
            latitude: latitude,
            longitude: longitude,
            state: state,
            street: street,
          )
        : _request?.copyWith(
            city: city,
            phoneNumber: phoneNumber,
            label: label,
            additionalInfo: additionalInfo,
            apartmentNumber: apartmentNumber,
            blockNumber: blockNumber,
            buildingName: buildingName,
            floorNumber: floorNumber,
            isDefault: isDefault,
            latitude: latitude,
            longitude: longitude,
            state: state,
            street: street,
          );
  }
}
