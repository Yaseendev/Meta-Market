import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Home/domain/repositories/home_repository.dart';

@lazySingleton
class GetHomeDataUseCase extends UseCase<NoParams, HomeData> {
  final HomeRepository _homeRepository;

  const GetHomeDataUseCase(this._homeRepository);

  @override
  FutureOrEitherFailureOrData<HomeData> call([NoParams? params]) async {
    return await _homeRepository.getHomeData();
  }
}
