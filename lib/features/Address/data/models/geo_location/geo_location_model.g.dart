// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocationModel _$GeoLocationModelFromJson(Map<String, dynamic> json) =>
    GeoLocationModel(
      id: (json['id'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoLocationModelToJson(GeoLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
