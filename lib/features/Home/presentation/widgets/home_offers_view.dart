import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_product_card.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class HomeOffersView extends StatelessWidget {
  final List<Product> offers;
  const HomeOffersView(this.offers, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISpaces.xs,
      children: offers.isEmpty
          ? []
          : [
              Text(LocaleKeys.offers.tr(context: context)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: UISpaces.sm,
                  children: offers.map((p) => HomeProductCard(p)).toList(),
                ),
              ),
            ],
    );
  }
}
