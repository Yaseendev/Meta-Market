import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
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
    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedCategoryId,
          destinations: List.generate(categories.length + 1, (index) {
            final category = index > 0 ? categories[index - 1] : null;
            return NavigationRailDestination(
              icon: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          index == 0
                              ? Icon(
                                  Icons.apps_rounded,
                                  color: selectedCategoryId == index
                                      ? AppColors.PRIMARY_COLOR
                                      : null,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: category?.image ?? '',
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                    height: 42,
                                    width: 42,
                                    errorWidget: (context, url, error) =>
                                        Assets.images.placeholder.image(),
                                    placeholder: (context, url) =>
                                        Assets.images.placeholder.image(),
                                  ),
                                ),
                          const SizedBox(height: 5),
                          Text(
                            category?.name ??
                                LocaleKeys.all.tr(context: context),
                            style: TextStyle(
                              color: selectedCategoryId == index
                                  ? AppColors.PRIMARY_COLOR
                                  : null,
                              fontSize: 13,
                              fontWeight: selectedCategoryId == index
                                  ? FontWeight.bold
                                  : null,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  if (selectedCategoryId == index)
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: 2,
                      height: 55,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                ],
              ),
              label: const SizedBox.shrink(),
            );
          }),
          backgroundColor: AppColors.BACKGROUND_COLOR,
          // extended: true,
          scrollable: true,
          useIndicator: false,
          minWidth: MediaQuery.sizeOf(context).width * .21,
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
        const VerticalDivider(thickness: .5, width: 1),
        const SizedBox(width: 8),
      ],
    );
  }
}
