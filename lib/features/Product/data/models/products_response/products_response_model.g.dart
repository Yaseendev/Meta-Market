// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponseModel _$ProductsResponseModelFromJson(
  Map<String, dynamic> json,
) => ProductsResponseModel(
  products: (json['content'] as List<dynamic>)
      .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalElements'] as num).toInt(),
  isLastPage: json['last'] as bool,
  isFirstPage: json['first'] as bool,
  pageSize: (json['size'] as num).toInt(),
  page: (json['number'] as num).toInt(),
);
