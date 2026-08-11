import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:searchfield/searchfield.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Home/presentation/blocs/search/home_search_cubit.dart';
import 'package:supermarket/features/Product/domain/entities/product.dart';

class HomeSearchWidget extends StatelessWidget {
  HomeSearchWidget({super.key});

  final HomeSearchCubit _searchCubit = getIt<HomeSearchCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UIMetrics.xs,
      children: [
        Expanded(
          child: SearchField<Product>(
            suggestions: _searchCubit.state
                .map((p) => SearchFieldListItem<Product>(p.name, item: p))
                .toList(),
            searchInputDecoration: SearchInputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onSearchTextChanged: (term) async {
              await _searchCubit.searchProducts(term);
              return _searchCubit.state
                  .map((p) => SearchFieldListItem<Product>(p.name, item: p))
                  .toList();
            },
            onSuggestionTap: (result) {
              context.pushNamed(
                AppRoutes.product,
                pathParameters: {'id': '${result.item?.id}'},
                extra: {
                  'name': result.item?.name,
                  'cart': context.read<CartCubit>(),
                },
              );
            },
          ),
        ),
        IconButton.filled(
          onPressed: () {
            context.push('${AppRoutes.home}/${AppRoutes.scan}');
          },
          icon: Icon(Icons.qr_code_scanner_rounded),
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
