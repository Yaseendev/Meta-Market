import 'package:supermarket/core/domain/types.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';

abstract class HomeRepository {
  FutureOrEitherFailureOrData<HomeData> getHomeData();
}
