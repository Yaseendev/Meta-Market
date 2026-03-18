part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashError extends SplashState {
  final String msg;
  SplashError({this.msg = 'Something Went Wrong'});

  @override
  List<Object> get props => [msg];
}

class SplashNoInternet extends SplashState {}

class SplashLoggedIn extends SplashState {}

class SplashLoggedOut extends SplashState {}
