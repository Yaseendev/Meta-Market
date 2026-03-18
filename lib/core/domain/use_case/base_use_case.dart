import 'package:supermarket/core/domain/types.dart';

abstract class UseCase<Input, Output> {
  const UseCase();
  FutureOrEitherFailureOrData<Output> call(Input params);
}
