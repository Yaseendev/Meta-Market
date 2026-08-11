import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Settings/domain/repositories/settings_repository.dart';

@lazySingleton
class SetCurrentLocaleUseCase implements UseCase<String, Unit> {
  final SettingsRepository _settingsRepository;

  const SetCurrentLocaleUseCase(this._settingsRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call(String params) async {
    return await _settingsRepository.setCurrentLocale(params);
  }
}
