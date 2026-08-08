import 'package:banner_carousel/banner_carousel.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Product/domain/entities/product_response.dart';
import 'package:supermarket/features/Product/presentation/blocs/product/product_cubit.dart';
import 'package:supermarket/features/Product/presentation/widgets/more_products_view.dart';

class ProductScreen extends StatelessWidget {
  final String? productName;
  const ProductScreen({super.key, this.productName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, BaseState<ProductResponse>>(
      builder: (context, state) {
        final productDetails = state.item;
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(productName ?? ''),
                  expandedHeight: MediaQuery.sizeOf(context).height * .3,
                  flexibleSpace: state.isSuccess
                      ? FlexibleSpaceBar(
                          background: (productDetails?.product.isDeal ?? false)
                              ? Banner(
                                  message: LocaleKeys.specialOffer.tr(
                                    context: context,
                                  ),
                                  location: BannerLocation.topEnd,
                                  child: BannerCarousel(
                                    banners:
                                        state.item?.product.images
                                            ?.map(
                                              (image) => BannerModel(
                                                boxFit: BoxFit.fill,
                                                imagePath: image.url,
                                                id: '${image.id}',
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                    height:
                                        MediaQuery.sizeOf(context).height * .3,
                                    margin: EdgeInsets.zero,
                                  ),
                                )
                              : BannerCarousel(
                                  banners:
                                      state.item?.product.images
                                          ?.map(
                                            (image) => BannerModel(
                                              boxFit: BoxFit.fill,
                                              imagePath: image.url,
                                              id: '${image.id}',
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  height:
                                      MediaQuery.sizeOf(context).height * .3,
                                  margin: EdgeInsets.zero,
                                ),
                          collapseMode: CollapseMode.parallax,
                        )
                      : null,
                ),
                if (state.isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: LoadingWidget(),
                  ),
                if (state.isFailure)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorView(
                      onRetry: () {
                        context.read<ProductCubit>().getProductInfo();
                      },
                    ),
                  ),
                if (state.isSuccess)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(UIMetrics.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetails?.product.name ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(productDetails?.product.brand ?? ''),
                          const SizedBox(height: UIMetrics.xs),
                          RatingBar.builder(
                            itemBuilder: (context, index) =>
                                Icon(Icons.star_rounded, color: Colors.amber),
                            allowHalfRating: true,
                            ignoreGestures: true,
                            initialRating:
                                productDetails?.product.rating?.toDouble() ??
                                0.0,
                            itemPadding: EdgeInsets.zero,
                            itemSize: 28,
                            unratedColor: Colors.grey.shade300,
                            onRatingUpdate: (value) {},
                          ),
                          const SizedBox(height: UIMetrics.sm),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade700,
                                width: .5,
                              ),
                              borderRadius: BorderRadius.circular(
                                UIMetrics.radius,
                              ),
                            ),
                            padding: EdgeInsets.all(UIMetrics.xs),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: UIMetrics.xs,
                              children: [
                                Text(
                                  LocaleKeys.description.tr(context: context),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(productDetails?.product.description ?? ''),
                              ],
                            ),
                          ),
                          const SizedBox(height: UIMetrics.sm),
                          if (productDetails?.relatedProducts.isNotEmpty ??
                              false)
                            MoreProductsView(
                              productDetails?.relatedProducts ?? [],
                              label: LocaleKeys.relatedProducts.tr(
                                context: context,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomSheet: state.isSuccess
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TextUtil.formatCurrency(
                          productDetails?.product.price ?? 0.0,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      BlocBuilder<CartCubit, BaseState<CartState>>(
                        builder: (context, cartState) {
                          final isLoading =
                              cartState.isLoading &&
                              (cartState.tempItem?.items.any(
                                    (t) =>
                                        t.product.id == state.item?.product.id,
                                  ) ??
                                  false);
                          final cartItem = cartState.item?.items
                              .singleWhereOrNull(
                                (t) => t.product.id == state.item?.product.id,
                              );
                          return cartItem == null
                              ? AppButton(
                                  title: LocaleKeys.addToCart.tr(
                                    context: context,
                                  ),
                                  onPress: () {
                                    if (state.item?.product != null) {
                                      context.read<CartCubit>().addItem(
                                        state.item!.product,
                                      );
                                    }
                                  },
                                  isLoading: isLoading,
                                )
                              : Row(
                                  spacing: UIMetrics.xs,
                                  children: [
                                    IconButton.filledTonal(
                                      onPressed: () {
                                        context
                                            .read<CartCubit>()
                                            .increaseQuantity(cartItem.id);
                                      },
                                      icon: Icon(Icons.remove_rounded),
                                    ),
                                    Text(
                                      '${cartItem.quantity}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.PRIMARY_COLOR,
                                      ),
                                    ),
                                    IconButton.filledTonal(
                                      onPressed: () {
                                        context
                                            .read<CartCubit>()
                                            .decreaseQuantity(cartItem.id);
                                      },
                                      icon: Icon(Icons.add_rounded),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}
