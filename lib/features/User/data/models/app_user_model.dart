import 'dart:convert';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'name_model.dart';

class AppUserModel extends AppUser {
  final int id;
  final NameModel name;
  final String email;
  final String phoneNumber;

  const AppUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  }) : super(id: id, name: name, email: email, phoneNumber: phoneNumber);

  AppUserModel copyWith({
    int? id,
    NameModel? name,
    String? email,
    String? phoneNumber,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    // result.addAll({'name': name.toMap()});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});

    return result;
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id']?.toInt(),
      name: NameModel.fromJson(map['name']),
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber)';
  }
}
