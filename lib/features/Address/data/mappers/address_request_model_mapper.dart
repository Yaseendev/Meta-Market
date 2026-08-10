import 'package:supermarket/features/Address/data/models/address_request/address_request_model.dart';
import 'package:supermarket/features/Address/domain/entities/address_request.dart';

extension AddressRequestModelMapper on AddressRequestModel {
  AddressRequest toDomain() {
    return AddressRequest(
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

extension AddressRequestMapper on AddressRequest {
  AddressRequestModel toModel() {
    return AddressRequestModel(
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
