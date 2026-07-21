import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/features/Cart/domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  const CartItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(imageUrl: item.product.image ?? ''),
        title: Text(item.product.name),
        subtitle: Text(TextUtil.formatCurrency(item.product.price)),
        trailing: Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_rounded)),
            Text('${item.quantity}'),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_circle_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
