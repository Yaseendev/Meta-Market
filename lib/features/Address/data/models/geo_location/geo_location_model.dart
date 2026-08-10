import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Address/domain/entities/geo_location.dart';

part 'geo_location_model.g.dart';

@JsonSerializable()
class GeoLocationModel {
  final int id;
  final double latitude;
  final double longitude;

  const GeoLocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationModelToJson(this);

  GeoLocation toDomain() =>
      GeoLocation(id: id, latitude: latitude, longitude: longitude);
}
