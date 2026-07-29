import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class HomeProductCard extends StatelessWidget {
  final Product product;
  const HomeProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UISpaces.sm),
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(UISpaces.sm),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                alignment: Alignment.center,
                fit: BoxFit.fill,
                height: 100,
                width: 120,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      TextUtil.formatCurrency(product.price, decimalDigits: 2),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
