import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/core/config/constants/storage_keys.dart';
import 'package:supermarket/features/User/data/models/app_user_model.dart';

abstract class UserLocalDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> saveUser(AppUserModel user);
  Future<AppUserModel?> getUser();
  Future<void> deleteUser();
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
    return await _secureStorage.write(key: StorageKeys.token, value: token);
  }

  @override
  Future<AppUserModel?> getUser() async {
    final userJson = _prefs.getString(StorageKeys.user);
    if (userJson != null) {
      return AppUserModel.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<void> saveUser(AppUserModel user) async {
    final userJson = user.toJson();
    await _prefs.setString(StorageKeys.user, userJson);
  }

  @override
  Future<void> deleteUser() async {
    await _prefs.remove(StorageKeys.user);
  }
}
