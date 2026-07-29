import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/features/Home/domain/entities/home_data.dart';
import 'package:supermarket/features/Home/presentation/blocs/home/home_cubit.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_categories_view.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_offers_view.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: UISpaces.xs,
            bottom: UISpaces.xs,
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
              end: UISpaces.xs,
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
                horizontal: UISpaces.sm,
                vertical: UISpaces.xs,
              ),
              children: [
                HomeSearchWidget(),
                const SizedBox(height: UISpaces.sm),
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
                const SizedBox(height: UISpaces.sm),
                HomeCategoriesView(state.item?.topCategories ?? []),
                const SizedBox(height: UISpaces.md),
                HomeOffersView(state.item?.offers ?? []),
                const SizedBox(height: UISpaces.sm),
              ],
            );
          } else if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //TODO: implement error view

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
