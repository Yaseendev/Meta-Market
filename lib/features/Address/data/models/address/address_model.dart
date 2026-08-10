import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Address/data/models/address_details/address_details_model.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final int id;
  final AddressDetailsModel details;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.details,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  Address toDomain() => Address(
    id: id,
    details: details.toDomain(),
    isDefault: isDefault,
  );
}
