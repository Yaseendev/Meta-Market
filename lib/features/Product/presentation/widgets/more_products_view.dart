import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Product/presentation/widgets/product_card.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class MoreProductsView extends StatelessWidget {
  final List<Product> products;
  final String label;
  const MoreProductsView(this.products, {super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UIMetrics.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.isEmpty
          ? []
          : [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Wrap(
                spacing: UIMetrics.xs,
                children: products.map((p) => ProductCard(p)).toList(),
              ),
            ],
    );
  }
}
