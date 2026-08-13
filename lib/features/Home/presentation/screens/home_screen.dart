import 'package:banner_carousel/banner_carousel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Home/presentation/blocs/home/home_cubit.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_categories_view.dart';
import 'package:supermarket/features/Product/presentation/widgets/more_products_view.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: UIMetrics.xs,
            bottom: UIMetrics.xs,
          ),
          child: Assets.images.logoTransparent.image(
            height: 10,
            fit: BoxFit.fill,
          ),
        ),
        titleSpacing: 6,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text('Meta Market'),
        ),
        centerTitle: false,
        elevation: 2,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 6,
              end: UIMetrics.xs,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, BaseState<HomeData>>(
        builder: (context, state) {
          if (state.isSuccess) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: UIMetrics.sm,
                vertical: UIMetrics.xs,
              ),
              children: [
                HomeSearchWidget(),
                const SizedBox(height: UIMetrics.sm),
                BannerCarousel(
                  banners: List.generate(
                    state.item?.banners.length ?? 0,
                    (b) => BannerModel(
                      imagePath: state.item?.banners[b].imageUrl ?? '',
                      id: '$b',
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: UIMetrics.sm),
                HomeCategoriesView(state.item?.topCategories ?? []),
                const SizedBox(height: UIMetrics.md),
                MoreProductsView(
                  state.item?.offers ?? [],
                  label: LocaleKeys.offers.tr(context: context),
                ),
                const SizedBox(height: UIMetrics.sm),
              ],
            );
          } else if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isFailure) {
            return ErrorView(
              onRetry: () {
                context.read<HomeCubit>().getData();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
