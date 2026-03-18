import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/errors/auth_token_failure.dart';
import 'package:supermarket/core/errors/no_connection_failure.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/google_auth_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/login_use_case.dart';
import 'package:supermarket/features/Auth/domain/use_cases/signup_use_case.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final CheckAppStateUseCase _checkAppStateUseCase;
  AuthBloc(
    this._loginUseCase,
    this._signupUseCase,
    this._googleAuthUseCase,
    this._checkAppStateUseCase,
  ) : super(AuthInitial()) {
    on<CheckAuthState>((event, emit) async {
      emit(AuthLoading());
      await _checkAppStateUseCase()
          .then((value) => value.fold(
              (l) => emit(l is AuthTokenFailure
                  ? AuthLoggedOut()
                  : l is NoInternetConnectionFailure
                      ? AuthNoInternet()
                      : AuthError(msg: l.message)),
              (r) => emit(AuthLoggedIn())))
          .onError((error, stackTrace) {
        emit(AuthError(msg: error.toString()));
      });
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrSuccess = await _loginUseCase(
          LoginParams(email: event.email, password: event.password));
      failureOrSuccess.fold(
          (failure) => emit(failure is NoInternetConnectionFailure
              ? AuthNoInternet()
              : AuthError(msg: failure.message)),
          (success) => emit(AuthLoggedIn(/*user: success*/)));
    });

    on<SingUpEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrSuccess = await _signupUseCase(SignupParams(
        email: event.email,
        password: event.password,
        name: event.name,
        phoneNumber: event.phone,
      ));
      failureOrSuccess.fold(
          (failure) => emit(failure is NoInternetConnectionFailure
              ? AuthNoInternet()
              : AuthError(msg: failure.message)),
          (success) => emit(AuthLoggedIn(/*user: success*/)));
    });

    on<GoogleAuthEvent>((event, emit) async {
      emit(AuthGoogleLoading());
      final failureOrSuccess = await _googleAuthUseCase(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(failure is NoInternetConnectionFailure
              ? AuthNoInternet()
              : AuthError(msg: failure.message)),
          (success) => emit(AuthLoggedIn(/*user: success*/)));
    });
  }
}
