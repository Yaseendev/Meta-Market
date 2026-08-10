// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDetailsModel _$AddressDetailsModelFromJson(Map<String, dynamic> json) =>
    AddressDetailsModel(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      street: json['street'] as String?,
      blockNumber: json['block_number'] as String?,
      floorNumber: json['floor_number'] as String?,
      phoneNumber: json['phone_number'] as String?,
      buildingName: json['building_name'] as String?,
      apartmentNumber: json['apartment_number'] as String?,
      additionalInfo: json['additional_info'] as String?,
      position: GeoLocationModel.fromJson(
        json['position'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AddressDetailsModelToJson(
  AddressDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
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
  'position': instance.position,
};
