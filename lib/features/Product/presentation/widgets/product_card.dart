import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.product,
          pathParameters: {'id': '${product.id}'},
          extra: {'name': product.name, 'cart': context.read<CartCubit>()},
        );
      },
      child: SizedBox(
        height: 200,
        width: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIMetrics.sm),
          ),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(UIMetrics.sm),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      height: 100,
                      width: 140,
                    ),
                  ),
                  Positioned.directional(
                    textDirection: TextDirection.ltr,
                    bottom: 0,
                    end: 0,

                    child: IconButton.filled(
                      onPressed: () {
                        context.read<CartCubit>().addItem(product);
                      },
                      icon: Icon(Icons.add_rounded),
                    ),
                  ),
                ],
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
                      Text(product.brand ?? ''),
                      Text(
                        TextUtil.formatCurrency(
                          product.price,
                          decimalDigits: 2,
                        ),
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
      ),
    );
  }
}
