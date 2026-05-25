import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Home/data/models/banner_model.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Product/data/models/category/category_model.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';

part 'home_data_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeDataModel {
  final List<BannerModel> banner;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  const HomeDataModel(
      {required this.banner, required this.categories, required this.products});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  HomeData toDomain() => HomeData(
        banner: banner.map((e) => e.toDomain()).toList(),
        categories: categories.map((e) => e.toDomain()).toList(),
        products: products.map((e) => e.toDomain()).toList(),
      );
}
