import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Home/domain/entities/banner.dart';

part 'banner_model.g.dart';

@JsonSerializable(createToJson: false)
class BannerModel {
  final String imageUrl;
  final String? id;

  const BannerModel({required this.imageUrl, required this.id});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Banner toDomain() => Banner(
        id: id,
        imageUrl: imageUrl,
      );
}
