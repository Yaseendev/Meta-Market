import 'package:json_annotation/json_annotation.dart';

part 'address_request_model.g.dart';

@JsonSerializable()
class AddressRequestModel {
  final String label;
  final String city;
  final String? state;
  final String? street;
  @JsonKey(name: 'block_number')
  final String? blockNumber;
  @JsonKey(name: 'floor_number')
  final String? floorNumber;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'building_name')
  final String? buildingName;
  @JsonKey(name: 'apartment_number')
  final String? apartmentNumber;
  @JsonKey(name: 'additional_info')
  final String? additionalInfo;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: 'is_default')
  final bool? isDefault;

  const AddressRequestModel({
    required this.city,
    this.state,
    this.street,
    this.blockNumber,
    this.floorNumber,
    required this.phoneNumber,
    this.buildingName,
    this.apartmentNumber,
    this.additionalInfo,
    required this.label,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  factory AddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestModelToJson(this);
}
