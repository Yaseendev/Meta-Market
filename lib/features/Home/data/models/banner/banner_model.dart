import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Home/domain/entities/banner.dart';

part 'banner_model.g.dart';

@JsonSerializable(createToJson: false)
class BannerModel {
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String? id;
  @JsonKey(name: 'target_url')
  final String? targetUrl;

  const BannerModel({
    required this.imageUrl,
    required this.id,
    this.targetUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Banner toDomain() => Banner(
        id: id,
        imageUrl: imageUrl,
        targetUrl: targetUrl,
      );
}
