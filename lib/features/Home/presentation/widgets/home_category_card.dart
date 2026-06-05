import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Product/domain/entities/category.dart';

class HomeCategoryCard extends StatelessWidget {
  final Category category;
  const HomeCategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UISpaces.sm),
          ),
          child: CachedNetworkImage,
        ),
        Text(category.name),
      ],
    );
  }
}
