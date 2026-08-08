import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Cart/presentation/widgets/cart_item_card.dart';
import 'package:supermarket/features/Cart/presentation/widgets/delivery_option_card.dart';
import 'package:supermarket/features/Cart/presentation/widgets/price_summary_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, BaseState<CartState>>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingWidget();
        } else if (state.isFailure) {
          return ErrorView(
            message: state.failure?.message,
            onRetry: () {
              context.read<CartCubit>().getCart();
            },
          );
        }
        return (state.item?.isEmpty ?? true)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: empty cart icon
                  Text(LocaleKeys.cart1.tr(context: context)),
                  Text(LocaleKeys.cart2.tr(context: context)),
                  const SizedBox(height: UIMetrics.lg),
                  ElevatedButton(
                    onPressed: () {
                      context.go(AppRoutes.home);
                    },
                    child: Text(LocaleKeys.startShopping.tr(context: context)),
                  ),
                ],
              )
            : ListView(
                children: [
                  // items
                  ...state.item?.items.map((item) => CartItemCard(item)) ?? [],
                  // deleviery/ pickup
                  DeliveryOptionCard(state.item?.deliveryOption),
                  // suptotal - delevery fees - total
                  PriceSummaryView(),
                  // checkout button
                  const SizedBox(height: UIMetrics.sm),
                  ElevatedButton(
                    onPressed: () {
                      //TODO
                    },
                    child: Text(LocaleKeys.order.tr(context: context)),
                  ),
                ],
              );
      },
    );
  }
}
