import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/User/domain/entities/name.dart';

part 'name_model.g.dart';

@JsonSerializable()
class NameModel extends Name {
  const NameModel({
    required super.first,
    required super.last,
  });

  NameModel copyWith({
    String? first,
    String? last,
  }) {
    return NameModel(first: first ?? this.first, last: last ?? this.last);
  }

  /// Convert from entity to model
  factory NameModel.fromEntity(Name entity) {
    return NameModel(
      first: entity.first,
      last: entity.last,
    );
  }

  factory NameModel.fromFullName(String fullName) {
    final nameList = fullName.split(' ');
    return NameModel(
      first: nameList.first,
      last: nameList.elementAtOrNull(1) ?? '',
    );
  }

  /// Convert from JSON
  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$NameModelToJson(this);

  @override
  String toString() => '$first $last';
}
