// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  id: (json['id'] as num).toInt(),
  details: AddressDetailsModel.fromJson(
    json['details'] as Map<String, dynamic>,
  ),
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'details': instance.details,
      'is_default': instance.isDefault,
    };
