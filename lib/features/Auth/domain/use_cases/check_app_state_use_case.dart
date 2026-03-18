import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/core/errors/failure.dart';
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart';

@lazySingleton
class CheckAppStateUseCase implements UseCase<NoParams, Unit> {
  final AuthRepository authRepository;

  const CheckAppStateUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call([NoParams? params]) async {
    return await authRepository.checkUser();
  }
}
