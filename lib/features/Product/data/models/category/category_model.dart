import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Product/domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel {
  final int id;
  final String name;
  final String? image;

  const CategoryModel({required this.id, required this.name, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toDomain() => Category(
        id: id,
        name: name,
        image: image,
      );
}
