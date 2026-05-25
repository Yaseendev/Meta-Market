import 'package:dartz/dartz.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';

abstract class AuthRepository {
  FutureOrEitherFailureOrData<Unit> checkUser();
  FutureOrEitherFailureOrData<AppUser> login(String email, String password);
  FutureOrEitherFailureOrData<AppUser> signup(String email, String password, NameModel name, String phoneNumber);
  FutureOrEitherFailureOrData<AppUser> authWithGoogle();
}
