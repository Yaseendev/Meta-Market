import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';

@lazySingleton
class DeleteUserUseCase implements UseCase<NoParams, Unit> {
  final UserRepository _userRepository;

  const DeleteUserUseCase(this._userRepository);

  @override
  FutureOrEitherFailureOrData<Unit> call([NoParams? params]) async {
    return await _userRepository.deleteUser();
  }
}
