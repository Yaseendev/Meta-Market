import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/Auth/domain/repositories/auth_repository.dart';

@lazySingleton
class LogOutUseCase implements UseCase<NoParams, Unit> {
  final AuthRepository _authRepository;

  const LogOutUseCase(this._authRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call([NoParams? params]) async {
    return await _authRepository.logout();
  }
}
