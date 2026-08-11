import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';

abstract class SettingsRepository {
  FutureOrEitherFailureOrData<String?> getCurrentLocale();
  FutureOrEitherFailureOrData<Unit> setCurrentLocale(String locale);
}
