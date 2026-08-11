import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_text_field.dart';
import 'package:supermarket/features/Categories/domain/entities/filter_options.dart';
import 'package:supermarket/features/Categories/presentations/widgets/products_filter_view.dart';
import 'package:supermarket/features/Product/presentation/blocs/products_cubit/products_cubit.dart';

class ProductsSearchWidget extends StatelessWidget {
  final ValueChanged<String> onType;
  final ProductsState? state;
  final ValueChanged<FilterOptions> onFilterApply;
  const ProductsSearchWidget({
    super.key,
    required this.onType,
    required this.state,
    required this.onFilterApply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UIMetrics.xs,
      children: [
        Expanded(
          child: AppTextField(
            hint: LocaleKeys.search.tr(context: context),
            textInputAction: TextInputAction.search,
            onChanged: onType,
          ),
        ),
        IconButton.filled(
          onPressed: state != null
              ? () {
                  showModalBottomSheet<FilterOptions>(
                    context: context,
                    isScrollControlled: true,
                    // constraints: const BoxConstraints(minWidth: 650, maxWidth: 650),
                    showDragHandle: true,
                    builder: (context) => ProductsFilterView(state!),
                  ).then((value) {
                    if (value != null) {
                      onFilterApply(value);
                    }
                  });
                }
              : null,
          icon: Icon(Icons.tune_rounded),
          padding: const EdgeInsets.all(12),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UIMetrics.radius),
            ),
          ),
        ),
      ],
    );
  }
}
