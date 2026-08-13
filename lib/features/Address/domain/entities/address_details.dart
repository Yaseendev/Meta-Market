import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Address/domain/entities/geo_location.dart';

class AddressDetails extends Equatable {
  final String label;
  final String city;
  final String state;
  final String? street;
  final String? blockNumber;
  final String? floorNumber;
  final String? phoneNumber;
  final String? buildingName;
  final String? apartmentNumber;
  final String? additionalInfo;
  final GeoLocation position;

  const AddressDetails({
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

  @override
  List<Object?> get props => [label, city, position];

  @override
  String toString() =>
      '${buildingName != null ? '$buildingName, ' : ''}${street != null ? '$street, ' : ''}$city, $state';

  AddressDetails copyWith({
    String? label,
    String? city,
    String? state,
    String? street,
    String? blockNumber,
    String? floorNumber,
    String? phoneNumber,
    String? buildingName,
    String? apartmentNumber,
    String? additionalInfo,
    GeoLocation? position,
  }) {
    return AddressDetails(
      label: label ?? this.label,
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      blockNumber: blockNumber ?? this.blockNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      buildingName: buildingName ?? this.buildingName,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      position: position ?? this.position,
    );
  }
}
