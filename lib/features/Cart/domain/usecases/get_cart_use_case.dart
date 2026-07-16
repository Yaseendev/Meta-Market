import 'package:injectable/injectable.dart';
import 'package:supermarket/core/domain/use_case/base_use_case.dart';
import 'package:supermarket/core/domain/use_case/no_params.dart';

@lazySingleton
class GetCartUseCase implements UseCase<NoParams, > {}