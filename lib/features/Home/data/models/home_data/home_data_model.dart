import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Home/data/models/banner/banner_model.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Categories/data/models/category/category_model.dart';
import 'package:supermarket/features/Product/data/models/product/product_model.dart';

part 'home_data_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeDataModel {
  final List<BannerModel> banner;
  @JsonKey(name: 'categories')
  final List<CategoryModel> topCategories;
  final List<ProductModel> offers;

  const HomeDataModel(
      {required this.banner,
      required this.topCategories,
      required this.offers});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  HomeData toDomain() => HomeData(
        banner: banner.map((e) => e.toDomain()).toList(),
        topCategories: topCategories.map((e) => e.toDomain()).toList(),
        offers: offers.map((e) => e.toDomain()).toList(),
      );
}
