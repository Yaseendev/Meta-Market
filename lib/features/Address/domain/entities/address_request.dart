import 'package:equatable/equatable.dart';

class AddressRequest extends Equatable {
  final String city;
  final String? state;
  final String? street;
  final String? blockNumber;
  final String? floorNumber;
  final String phoneNumber;
  final String? buildingName;
  final String? apartmentNumber;
  final String? additionalInfo;
  final String label;
  final double? latitude;
  final double? longitude;
  final bool? isDefault;

  const AddressRequest({
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

  @override
  List<Object?> get props => [
    city,
    state,
    street,
    blockNumber,
    floorNumber,
    phoneNumber,
    buildingName,
    apartmentNumber,
    additionalInfo,
    label,
    latitude,
    longitude,
    isDefault,
  ];

  AddressRequest copyWith({
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
    return AddressRequest(
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      blockNumber: blockNumber ?? this.blockNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      buildingName: buildingName ?? this.buildingName,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      label: label ?? this.label,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
