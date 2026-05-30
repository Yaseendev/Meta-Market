import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/features/Auth/domain/use_cases/check_app_state_use_case.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@lazySingleton
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAppStateUseCase checkAppStateUsecase;
  SplashBloc(this.checkAppStateUsecase) : super(SplashInitial()) {}
}
