import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/core/config/constants/storage_keys.dart';

abstract class SettingsLocalDataSource {
  Future<String?> getLocale();
  Future<void> setLocale(String locale);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _prefs;

  const SettingsLocalDataSourceImpl(this._prefs);

  @override
  Future<String?> getLocale() async {
    final locale = await _prefs.getString(StorageKeys.locale);
    return locale;
  }

  @override
  Future<void> setLocale(String locale) async {
    await _prefs.setString(StorageKeys.locale, locale);
  }
}
