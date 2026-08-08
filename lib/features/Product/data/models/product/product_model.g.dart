// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: json['price'] as num,
  image: json['image'] as String?,
  brand: json['brand'] as String?,
  description: json['description'] as String?,
  images: (json['images'] as List<dynamic>?)
      ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  isDeal: json['isDeal'] as bool?,
  rating: json['rating'] as num?,
);
