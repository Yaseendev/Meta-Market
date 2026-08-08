import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/data/repositories/base_repository_impl.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/errors/user_not_found_failure.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';
import 'package:supermarket/features/User/domain/usecases/edit_user_profile_use_case.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl with BaseRepositoryImpl implements UserRepository {
  final UserLocalDataSource _userLocalDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userLocalDataSource, this._userRemoteDataSource);

  @override
  FutureOrEitherFailureOrData<AppUser> getUserProfile() async {
    return await request(() async {
      await _getUserProfile();
      final user = await _userLocalDataSource.getUser();
      if (user == null) {
        return const Left(UserNotFoundFailure());
      }
      return Right(user);
    });
  }

  FutureOrEitherFailureOrData<Unit> _getUserProfile() async {
    return await request(() async {
      final userData = await _userRemoteDataSource.getUser();
      await _userLocalDataSource.saveUser(userData);
      return const Right(unit);
    });
  }

  @override
  FutureOrEitherFailureOrData<AppUser> editUserProfile(
    EditProfileParams params,
  ) async {
    return await request(() async {
      final user = await _userRemoteDataSource.editUserProfile(
        email: params.email,
        firstName: params.name.first,
        lastName: params.name.last,
        phoneNumber: params.phoneNumber,
      );
      await _userLocalDataSource.saveUser(user);
      return Right(user);
    });
  }

  @override
  FutureOrEitherFailureOrData<Unit> deleteUser() async {
    return await request(() async {
      await _userRemoteDataSource.deleteUser();
      await _userLocalDataSource.deleteUser();
      return const Right(unit);
    });
  }
}
