import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/usecases/get_user_profile_use_case.dart';

@lazySingleton
class ProfileCubit extends Cubit<BaseState<AppUser>> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  ProfileCubit(this._getUserProfileUseCase) : super(const BaseState.init());

  void loadUser() async {
    emit(state.setLoadingState());
    final result = await _getUserProfileUseCase();

    result.fold(
      (l) => emit(state.setFailureState(l)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  void setUser(AppUser user) {
    emit(state.setSuccessState(user));
  }

  void reset() => emit(const BaseState.init());
}
