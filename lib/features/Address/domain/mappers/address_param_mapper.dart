import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';

extension AddressParamMapper on Address {
  AddressRequest toRequest() {
    return AddressRequest(
      city: details.city,
      phoneNumber: details.phoneNumber ?? '',
      label: details.label,
      additionalInfo: details.additionalInfo,
      apartmentNumber: details.apartmentNumber,
      blockNumber: details.blockNumber,
      buildingName: details.buildingName,
      floorNumber: details.floorNumber,
      isDefault: isDefault,
      latitude: details.position.latitude,
      longitude: details.position.longitude,
      state: details.state,
      street: details.street,
    );
  }
}
