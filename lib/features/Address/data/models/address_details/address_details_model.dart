import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Address/data/models/geo_location/geo_location_model.dart';
import 'package:supermarket/features/Address/domain/entities/address_details.dart';

part 'address_details_model.g.dart';

@JsonSerializable()
class AddressDetailsModel {
  final int id;
  final String label;
  final String city;
  final String state;
  final String? street;
  @JsonKey(name: 'block_number')
  final String? blockNumber;
  @JsonKey(name: 'floor_number')
  final String? floorNumber;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'building_name')
  final String? buildingName;
  @JsonKey(name: 'apartment_number')
  final String? apartmentNumber;
  @JsonKey(name: 'additional_info')
  final String? additionalInfo;
  final GeoLocationModel position;

  const AddressDetailsModel({
    required this.id,
    required this.label,
    required this.city,
    required this.state,
    this.street,
    this.blockNumber,
    this.floorNumber,
    this.phoneNumber,
    this.buildingName,
    this.apartmentNumber,
    this.additionalInfo,
    required this.position,
  });

  factory AddressDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailsModelToJson(this);

  AddressDetails toDomain() => AddressDetails(
    id: id,
    city: city,
    phoneNumber: phoneNumber,
    label: label,
    additionalInfo: additionalInfo,
    apartmentNumber: apartmentNumber,
    blockNumber: blockNumber,
    buildingName: buildingName,
    floorNumber: floorNumber,
    position: position.toDomain(),
    state: state,
    street: street,
  );
}
