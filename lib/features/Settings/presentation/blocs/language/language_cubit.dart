import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:injectable/injectable.dart';
import 'package:supermarket/features/Settings/domain/use_cases/get_current_locale_use_case.dart';
import 'package:supermarket/features/Settings/domain/use_cases/set_current_locale_use_case.dart';

@lazySingleton
class LanguageCubit extends Cubit<Locale> {
  final GetCurrentLocaleUseCase _getCurrentLocaleUseCase;
  final SetCurrentLocaleUseCase _setCurrentLocaleUseCase;
  final Locale _defaultLocale = const Locale('en');
  LanguageCubit(this._getCurrentLocaleUseCase, this._setCurrentLocaleUseCase)
    : super(const Locale('en'));

  @PostConstruct(preResolve: true)
  Future<void> getInitLanguage() async {
    final result = await _getCurrentLocaleUseCase();
    final locale =
        result.getOrElse(() => _defaultLocale.languageCode) ??
        _defaultLocale.languageCode;
    emit(Locale.fromSubtags(languageCode: locale));
  }

  void changeLanguage(String localeCode) async {
    _setCurrentLocaleUseCase(localeCode);
    emit(Locale.fromSubtags(languageCode: localeCode));
  }
}
