// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressRequestModel _$AddressRequestModelFromJson(Map<String, dynamic> json) =>
    AddressRequestModel(
      city: json['city'] as String,
      state: json['state'] as String?,
      street: json['street'] as String?,
      blockNumber: json['block_number'] as String?,
      floorNumber: json['floor_number'] as String?,
      phoneNumber: json['phone_number'] as String,
      buildingName: json['building_name'] as String?,
      apartmentNumber: json['apartment_number'] as String?,
      additionalInfo: json['additional_info'] as String?,
      label: json['label'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$AddressRequestModelToJson(
  AddressRequestModel instance,
) => <String, dynamic>{
  'label': instance.label,
  'city': instance.city,
  'state': instance.state,
  'street': instance.street,
  'block_number': instance.blockNumber,
  'floor_number': instance.floorNumber,
  'phone_number': instance.phoneNumber,
  'building_name': instance.buildingName,
  'apartment_number': instance.apartmentNumber,
  'additional_info': instance.additionalInfo,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'is_default': instance.isDefault,
};
