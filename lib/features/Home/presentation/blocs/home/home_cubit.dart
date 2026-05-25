import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Home/domain/use_cases/get_home_data_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<BaseState<HomeData>> {
  final GetHomeDataUseCase _getHomeDataUseCase;
  HomeCubit(this._getHomeDataUseCase) : super(const BaseState.init()) {
    getData();
  }

  void getData() async {
    emit(state.setInProgressState());
    final result = await _getHomeDataUseCase();
    result.fold(
      (l) => emit(state.setFailureState(l)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
