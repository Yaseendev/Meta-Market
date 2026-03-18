import 'package:equatable/equatable.dart';

import 'name.dart';

class AppUser extends Equatable {
  final int id;
  final Name name;
  final String email;
  final String phoneNumber;

  const AppUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber});

  @override
  List<Object?> get props => [id, name, email, phoneNumber];
}
