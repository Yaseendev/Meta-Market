import 'package:flutter/material.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_search_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesCubit _categoriesCubit = getIt<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: UISpaces.sm, vertical: UISpaces.xs),
        child: Column(
          children: [
            HomeSearchWidget(),
            const SizedBox(height: UISpaces.sm),
            Row(
              children: [
                NavigationRail(
                  selectedIndex: ,
                  destinations: [
                    
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
