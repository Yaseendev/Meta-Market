import 'package:flutter/material.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(product.name),
          Text('${product.price}'),
        ],
      ),
    );
  }
}
