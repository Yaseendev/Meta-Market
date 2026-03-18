import 'package:dartz/dartz.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> checkUser();
  Future<Either<Failure, AppUser>> login(String email, String password);
  Future<Either<Failure, AppUser>> signup(String email, String password, NameModel name, String phoneNumber);
  Future<Either<Failure, AppUser>> authWithGoogle();
}
