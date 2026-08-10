import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Address/domain/entities/address_details.dart';

class Address extends Equatable {
  final int id;
  final AddressDetails details;
  final bool isDefault;

  const Address({
    required this.id,
    required this.details,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, isDefault];

  Address copyWith({AddressDetails? details, bool? isDefault}) {
    return Address(
      id: this.id,
      details: details ?? this.details,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
