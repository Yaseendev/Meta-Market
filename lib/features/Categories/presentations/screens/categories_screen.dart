import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Categories/domain/entities/category.dart';
import 'package:supermarket/features/Categories/presentations/blocs/categories_cubit/categories_cubit.dart';
import 'package:supermarket/features/Categories/presentations/widgets/categories_view.dart';
import 'package:supermarket/features/Categories/presentations/widgets/products_search_widget.dart';
import 'package:supermarket/features/Product/presentation/blocs/products_cubit/products_cubit.dart';
import 'package:supermarket/features/Product/presentation/widgets/products_view.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesCubit _categoriesCubit = getIt<CategoriesCubit>();
  final ProductsCubit _productsCubit = getIt<ProductsCubit>();

  @override
  void initState() {
    super.initState();
    _categoriesCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, BaseState<List<Category>>>(
      bloc: _categoriesCubit,
      listener: (context, state) {
        if (state.isSuccess) {
          _productsCubit.getProducts();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIMetrics.sm,
            vertical: UIMetrics.xs,
          ),
          child: BlocBuilder<CategoriesCubit, BaseState<List<Category>>>(
            bloc: _categoriesCubit,
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingWidget();
              } else if (state.isFailure) {
                return ErrorView(
                  message: state.failure?.message,
                  onRetry: _categoriesCubit.getCategories,
                );
              } else {
                final data = state.item ?? [];
                return data.isEmpty
                    ? Center(
                        child: Text(LocaleKeys.noData.tr(context: context)),
                      )
                    : SafeArea(
                        child: Column(
                          children: [
                            BlocBuilder<
                              ProductsCubit,
                              BaseState<ProductsState>
                            >(
                              bloc: _productsCubit,
                              builder: (context, productsState) {
                                return ProductsSearchWidget(
                                  onType: (value) {
                                    _productsCubit.getProducts(
                                      searchTerm: value.trim(),
                                    );
                                  },
                                  state: productsState.item,
                                  onFilterApply: (value) {
                                    _productsCubit.getProducts(
                                      filterOptions: value,
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: UIMetrics.sm),
                            Expanded(
                              child: BlocBuilder<ProductsCubit, BaseState<ProductsState>>(
                                bloc: _productsCubit,
                                builder: (context, productsState) {
                                  return Row(
                                    children: [
                                      CategoriesView(
                                        data,
                                        selectedCategoryId:
                                            productsState
                                                .item
                                                ?.selectedCategory ??
                                            0,
                                        onSelected: (c) => _productsCubit
                                            .getProducts(categoryId: c),
                                      ),
                                      Expanded(
                                        child:
                                            productsState.item?.products == null
                                            ? switch (productsState.status) {
                                                BaseStatus.failure => ErrorView(
                                                  message: productsState
                                                      .failure
                                                      ?.message,
                                                  onRetry: () => _productsCubit
                                                      .getProducts(
                                                        categoryId: productsState
                                                            .item
                                                            ?.selectedCategory,
                                                      ),
                                                ),
                                                BaseStatus.loading =>
                                                  const LoadingWidget(),
                                                BaseStatus.success =>
                                                  ProductsView(
                                                    products:
                                                        productsState
                                                            .item
                                                            ?.products ??
                                                        [],
                                                  ),
                                                _ => const SizedBox.shrink(),
                                              }
                                            : ProductsView(
                                                products:
                                                    productsState
                                                        .item
                                                        ?.products ??
                                                    [],
                                                onLoadMore: () {
                                                  _productsCubit
                                                      .getNextProducts();
                                                },
                                                isLoading:
                                                    productsState.isLoading,
                                              ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
