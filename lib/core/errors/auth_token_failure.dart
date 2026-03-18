import 'failure.dart';

class AuthTokenFailure extends Failure {

  AuthTokenFailure({super.message});

  @override
  List<Object?> get props => [super.message];
}