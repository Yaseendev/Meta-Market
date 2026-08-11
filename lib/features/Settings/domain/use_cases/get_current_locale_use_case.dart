import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Settings/domain/repositories/settings_repository.dart';

@lazySingleton
class GetCurrentLocaleUseCase implements UseCase<NoParams, String?> {
  final SettingsRepository _settingsRepository;

  const GetCurrentLocaleUseCase(this._settingsRepository);

  @override
  FutureOrEitherFailureOrData<String?> call([NoParams? params]) async {
    return await _settingsRepository.getCurrentLocale();
  }
}
