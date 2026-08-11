import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/features/Categories/domain/entities/filter_options.dart';
import 'package:supermarket/features/Categories/domain/enums/sort_type.dart';
import 'package:supermarket/features/Product/presentation/blocs/products_cubit/products_cubit.dart';

class ProductsFilterView extends StatefulWidget {
  final ProductsState state;
  const ProductsFilterView(this.state, {super.key});

  @override
  State<ProductsFilterView> createState() => _ProductsFilterViewState();
}

class _ProductsFilterViewState extends State<ProductsFilterView> {
  late FilterOptions _filterOptions;

  @override
  void initState() {
    _filterOptions = widget.state.filterOptions ?? FilterOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIMetrics.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: UIMetrics.xs),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.deals.tr(context: context),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              CheckboxListTile(
                value: _filterOptions.isDeal ?? false,
                onChanged: (v) {
                  setState(() {
                    _filterOptions = _filterOptions.copyWith(isDeal: v);
                  });
                },
                title: Text(LocaleKeys.specialOffers.tr(context: context)),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: UIMetrics.xs),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.price.tr(context: context),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: UIMetrics.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_filterOptions.minPrice?.toStringAsFixed(2) ?? '0'),
                    Text(_filterOptions.maxPrice?.toStringAsFixed(2) ?? '10'),
                  ],
                ),
              ),
              RangeSlider(
                values: RangeValues(
                  _filterOptions.minPrice ?? 0.0,
                  _filterOptions.maxPrice ?? 10.0,
                ),
                onChanged: (value) {
                  setState(() {
                    _filterOptions = _filterOptions.copyWith(
                      minPrice: value.start,
                      maxPrice: value.end,
                    );
                  });
                },
                min: 0.0,
                max: 10.0,
                divisions: 200,
                labels: RangeLabels(
                  _filterOptions.minPrice?.toStringAsFixed(2) ?? '0',
                  _filterOptions.maxPrice?.toStringAsFixed(2) ?? '10',
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: UIMetrics.xs),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.sortBy.tr(context: context),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: UIMetrics.sm),
              RadioGroup<SortType>(
                groupValue: _filterOptions.sortType,
                onChanged: (value) {
                  setState(() {
                    _filterOptions = _filterOptions.copyWith(sortType: value);
                  });
                },
                child: Column(
                  children: SortType.values.map((op) => RadioListTile(
                      value: op,
                      title: Text(
                        op.name.toLowerCase().tr(context: context),
                        style: TextStyle(fontSize: 14),
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    )).toList(),
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: UIMetrics.xs),
          Row(
            spacing: UIMetrics.md,
            children: [
              Flexible(
                child: AppButton(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: AppColors.PRIMARY_COLOR,
                  expanded: true,
                  title: LocaleKeys.clearAll.tr(context: context),
                  onPress: () {
                    Navigator.of(context).pop(FilterOptions());
                  },
                ),
              ),
              Flexible(
                child: AppButton(
                  expanded: true,
                  title: LocaleKeys.apply.tr(context: context),
                  onPress: () {
                    Navigator.of(context).pop(_filterOptions);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
