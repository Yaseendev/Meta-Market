import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';

@lazySingleton
class LoginUseCase implements UseCase<LoginParams, AppUser> {
  final AuthRepository authRepository;

  const LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, AppUser>> call(LoginParams params) async {
    return await authRepository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
