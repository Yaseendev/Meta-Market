import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/User/domain/usecases/delete_user_use_case.dart';

@injectable
class DeleteProfileCubit extends Cubit<BaseState> {
  final DeleteUserUseCase _deleteUserUseCase;
  DeleteProfileCubit(this._deleteUserUseCase) : super(const BaseState.init());

  void deleteUser() async {
    emit(state.setLoadingState());
    final result = await _deleteUserUseCase();
    emit(
      result.fold(
        (f) => state.setFailureState(f),
        (_) => const BaseState.success(),
      ),
    );
  }
}
