part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthGoogleLoading extends AuthState {}

class AuthFacebookLoading extends AuthState {}

class AuthError extends AuthState {
  final String msg;
  AuthError({this.msg = 'Something Went Wrong'});

  @override
  List<Object> get props => [msg];
}

class AuthNoInternet extends AuthState {}

class AuthLoggedIn extends AuthState {
  AuthLoggedIn();

  @override
  List<Object> get props => [];
}

class AuthLoggedOut extends AuthState {}