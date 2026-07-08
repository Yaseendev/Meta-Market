import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

class CategoriesView extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<int?> onSelected;
  final int selectedCategoryId;
  const CategoriesView(
    this.categories, {
    super.key,
    required this.onSelected,
    required this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            NavigationRail(
              selectedIndex: selectedCategoryId,
              destinations: List.generate(categories.length + 1, (index) {
                final category = index > 0 ? categories[index - 1] : null;
                return NavigationRailDestination(
                  icon: index == 0
                      ? Icon(Icons.apps_rounded)
                      : CachedNetworkImage(
                          imageUrl: category?.image ?? '',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                  label: Text(
                      category?.name ?? LocaleKeys.all.tr(context: context)),
                );
              }),
              onDestinationSelected: (value) {
                final index = value - 1;
                if (index.isNegative) {
                  onSelected(null);
                } else {
                  final id = categories[index].id;
                  onSelected(id);
                }
              },
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ],
        ),
      ],
    );
  }
}
