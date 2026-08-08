import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';

@lazySingleton
class GetUserProfileUseCase implements UseCase<NoParams, AppUser> {
  final UserRepository _userRepository;

  const GetUserProfileUseCase(this._userRepository);

  @override
  FutureOrEitherFailureOrData<AppUser> call([NoParams? params]) async {
    return await _userRepository.getUserProfile();
  }
}
