import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Home/domain/entities/banner.dart';
import 'package:supermarket/features/Product/domain/entities/category.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class HomeData extends Equatable {
  final List<Banner> banner;
  final List<Category> categories;
  final List<Product> products;

  const HomeData(
      {required this.banner, required this.categories, required this.products});

  @override
  List<Object?> get props => [banner, categories, products];
}
