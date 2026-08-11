import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';
import 'package:supermarket/features/Product/presentation/widgets/product_card.dart';

class ProductsView extends StatefulWidget {
  final List<Product> products;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  const ProductsView({
    super.key,
    required this.products,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels == position.maxScrollExtent) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.products.isEmpty
        ? Center(child: Text(LocaleKeys.noData.tr(context: context)))
        : Column(
            children: [
              Expanded(
                child: GridView.count(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  childAspectRatio: 140 / 200,
                  mainAxisSpacing: UIMetrics.xs,
                  children: widget.products.map((p) => ProductCard(p)).toList(),
                ),
              ),
              if (widget.isLoading) ...[
                const SizedBox(height: UIMetrics.sm),
                CircularProgressIndicator(),
              ],
              const SizedBox(height: UIMetrics.xs),
            ],
          )
    // Wrap(
    //     alignment: WrapAlignment.spaceAround,
    //     runSpacing: UIMetrics.sm,
    //     children: products.map((p) => ProductCard(p)).toList(),
    //   )
    ;
  }
}
