import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Product/domain/entities/product_image.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final num price;
  final String? image;
  final String? description;
  final String? brand;
  final List<ProductImage>? images;
  final num? rating;
  final bool? isDeal;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.brand,
    this.description,
    this.images,
    this.isDeal,
    this.rating,
  });

  @override
  List<Object?> get props => [id, price];
}
