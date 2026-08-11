import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Categories/domain/enums/sort_type.dart';

class FilterOptions extends Equatable {
  final double? minPrice;
  final double? maxPrice;
  final bool? isDeal;
  final SortType? sortType;

  const FilterOptions({
    this.minPrice,
    this.maxPrice,
    this.isDeal,
    this.sortType = SortType.RELEVANCE,
  });

  FilterOptions copyWith({
    double? minPrice,
    double? maxPrice,
    bool? isDeal,
    SortType? sortType,
  }) {
    return FilterOptions(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isDeal: isDeal ?? this.isDeal,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [minPrice, maxPrice, isDeal, sortType];
}
