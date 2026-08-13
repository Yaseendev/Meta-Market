import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/entities/name.dart';
import 'package:supermarket/features/User/domain/usecases/edit_user_profile_use_case.dart';

@injectable
class EditProfileCubit extends Cubit<BaseState<AppUser>> {
  final EditUserProfileUseCase _editUserProfileUseCase;
  final AppUser profile;
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  EditProfileCubit(@factoryParam this.profile, this._editUserProfileUseCase)
    : super(const BaseState.init()) {
    _email = profile.email;
    _firstName = profile.name.first;
    _lastName = profile.name.last;
    _phone = profile.phoneNumber;
  }

  void setEmail(String value) => _email = value;
  void setFirstName(String value) => _firstName = value;
  void setLastName(String value) => _lastName = value;
  void setPhone(String value) => _phone = value;

  void editProfile() async {
    emit(state.setLoadingState());
    final result = await _editUserProfileUseCase(
      EditProfileParams(
        name: Name(first: _firstName, last: _lastName),
        email: _email,
        phoneNumber: _phone,
      ),
    );
    result.fold(
      (f) {
        emit(state.setFailureState(f));
      },
      (data) {
        emit(state.setSuccessState(data));
      },
    );
  }
}
