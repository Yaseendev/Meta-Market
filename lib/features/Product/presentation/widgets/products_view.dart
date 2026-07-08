import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/presentation/widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  final List<Product> products;
  const ProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Center(
            child: Text(LocaleKeys.noData.tr(context: context)),
          )
        : Wrap(
            children: products.map((p) => ProductCard(p)).toList(),
          );
  }
}
