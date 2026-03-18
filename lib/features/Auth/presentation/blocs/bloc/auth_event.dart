part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthState extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SingUpEvent extends AuthEvent {
  final String email;
  final NameModel name;
  final String password;
  final String phone;

  const SingUpEvent({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  @override
  List<Object> get props => [email, name, password, phone];
}

class GoogleAuthEvent extends AuthEvent {}
