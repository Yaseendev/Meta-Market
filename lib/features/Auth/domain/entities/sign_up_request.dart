import 'package:equatable/equatable.dart';
import 'package:supermarket/features/User/domain/entities/name.dart';

class SignupRequest extends Equatable {
  final String email;
  final String password;
  final String phoneNumber;
  final Name name;

  const SignupRequest({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.name,
  });

  @override
  List<Object?> get props => [
        email,
        name,
        password,
        phoneNumber,
      ];
}