import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_search_widget.dart';

class CategoriesView extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<int> onSelected;
  const CategoriesView(
    this.categories, {
    super.key,
    required this.onSelected,
  });

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeSearchWidget(),
        const SizedBox(height: UISpaces.sm),
        Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              destinations:
                  List.generate(widget.categories.length + 1, (index) {
                final category =
                    index > 0 ? widget.categories[index - 1] : null;
                return NavigationRailDestination(
                  icon: index == 0
                      ? Icons.apps_rounded
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
                widget.onSelected(value);
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ],
        ),
      ],
    );
  }
}
