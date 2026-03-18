import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignupUseCase implements UseCase<SignupParams, AppUser> {
  final AuthRepository authRepository;

  const SignupUseCase({required this.authRepository});

  @override
  Future<Either<Failure, AppUser>> call(SignupParams params) async {
    return await authRepository.signup(
      params.email,
      params.password,
      params.name,
      params.phoneNumber,
    );
  }
}

class SignupParams extends Equatable {
  final String email;
  final String password;
  final NameModel name;
  final String phoneNumber;

  SignupParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [email, password, name, phoneNumber];
}
