import 'package:equatable/equatable.dart';

class ProductImage extends Equatable {
  final int id;
  final String url;

  const ProductImage({required this.id, required this.url});

  @override
  List<Object?> get props => [id, url];
}
