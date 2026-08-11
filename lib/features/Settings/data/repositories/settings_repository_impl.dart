import 'dart:io' show Platform;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/features/Settings/data/data_sources/local/settings_local_data_source.dart';
import 'package:supermarket/features/Settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  FutureOrEitherFailureOrData<String?> getCurrentLocale() async {
    try {
      final locale = await _localDataSource.getLocale();
      final sysLocale = Platform.localeName.split('_').firstOrNull;
      return Right(locale ?? sysLocale);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  FutureOrEitherFailureOrData<Unit> setCurrentLocale(String locale) async {
    try {
      await _localDataSource.setLocale(locale);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure());
    }
  }
}
