import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/usecases/edit_user_profile_use_case.dart';

abstract class UserRepository {
  const UserRepository();

  FutureOrEitherFailureOrData<AppUser> getUserProfile();
  FutureOrEitherFailureOrData<AppUser> editUserProfile(EditProfileParams params);
  FutureOrEitherFailureOrData<Unit> deleteUser();
}
