import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class HomeProductCard extends StatelessWidget {
  final Product product;
  const HomeProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISpaces.sm),
      ),
      child: Column(
        spacing: 5,
        children: [
          CachedNetworkImage(
            imageUrl: product.image ?? '',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            height: 60,
            width: 60,
          ),
          Text(product.name),
          Text('${product.price}'),
        ],
      ),
    );
  }
}
