import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/core/config/constants/storage_keys.dart';

abstract class UserLocalDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  const UserLocalDataSourceImpl(this._secureStorage, this._prefs);

  @override
  Future<String?> getToken() async {
    if (!(_prefs.getBool(StorageKeys.hasRunBefore) ?? false)) {
      _secureStorage.deleteAll();
      _prefs.setBool(StorageKeys.hasRunBefore, true);
      return null;
    }
    return await _secureStorage.read(key: StorageKeys.token);
  }

  @override
  Future<void> saveToken(String token) async {
    return await _secureStorage.write(
      key: StorageKeys.token,
      value: token,
    );
  }
}
