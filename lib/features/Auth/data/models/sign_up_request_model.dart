import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Auth/domain/entities/sign_up_request.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignupRequestModel extends SignupRequest {
  final NameModel name;

  const SignupRequestModel({
    required super.email,
    required super.password,
    required super.phoneNumber,
    required this.name,
  }) : super(name: name);

  factory SignupRequestModel.fromEntity(SignupRequest entity) {
    return SignupRequestModel(
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      name: NameModel.fromEntity(entity.name),
    );
  }

  /// Convert from JSON
  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$SignupRequestModelToJson(this);
}
