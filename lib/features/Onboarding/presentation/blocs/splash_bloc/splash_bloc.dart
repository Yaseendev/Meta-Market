import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/core/errors/auth_token_failure.dart';
import 'package:supermarket/core/errors/no_connection_failure.dart';
import 'package:supermarket/core/services/service_locator.dart';
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAppStateUseCase checkAppStateUsecase =
      locator.get<CheckAppStateUseCase>();
  SplashBloc() : super(SplashInitial()) {}
}
