import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GoogleAuthUseCase implements UseCase<NoParams, AppUser> {
  final AuthRepository authRepository;

  const GoogleAuthUseCase({required this.authRepository});

  @override
  Future<Either<Failure, AppUser>> call(NoParams params) async {
    return await authRepository.authWithGoogle();
  }
}
