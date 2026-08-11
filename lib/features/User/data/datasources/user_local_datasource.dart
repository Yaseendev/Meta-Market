import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/core/config/constants/storage_keys.dart';
import 'package:supermarket/features/User/data/models/app_user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(AppUserModel user);
  Future<AppUserModel?> getUser();
  Future<void> deleteUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences _prefs;

  const UserLocalDataSourceImpl(this._prefs);

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
