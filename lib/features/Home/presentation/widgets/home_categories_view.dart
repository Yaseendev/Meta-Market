import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_category_card.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

class HomeCategoriesView extends StatelessWidget {
  final List<Category> categories;
  const HomeCategoriesView(this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISpaces.xs,
      children: categories.isNotEmpty
          ? [
              Text(LocaleKeys.topCat.tr(context: context)),
              Wrap(
                spacing: UISpaces.sm,
                children: categories.map((c) => HomeCategoryCard(c)).toList(),
              ),
            ]
          : [],
    );
  }
}
