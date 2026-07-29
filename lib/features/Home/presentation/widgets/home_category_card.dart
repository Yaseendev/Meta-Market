import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(UISpaces.xs),
            child: CachedNetworkImage(
              imageUrl: category.image ?? '',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              height: 60,
              width: 60,
              errorWidget: (context, url, error) =>
                  Assets.images.placeholder.image(),
              placeholder: (context, url) => Assets.images.placeholder.image(),
            ),
          ),
        ),
        Text(category.name),
      ],
    );
  }
}
