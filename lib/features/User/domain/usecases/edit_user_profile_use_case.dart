import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/domain/entities/name.dart';
import 'package:supermarket/features/User/domain/repositories/user_repository.dart';

@lazySingleton
class EditUserProfileUseCase implements UseCase<EditProfileParams, AppUser> {
  final UserRepository _userRepository;

  const EditUserProfileUseCase(this._userRepository);

  @override
  FutureOrEitherFailureOrData<AppUser> call(EditProfileParams params) async {
    return await _userRepository.editUserProfile(params);
  }
}

class EditProfileParams extends Equatable {
  final Name name;
  final String email;
  final String phoneNumber;

  const EditProfileParams({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [name, email, phoneNumber];
}
