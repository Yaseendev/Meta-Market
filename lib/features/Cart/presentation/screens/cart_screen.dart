import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Cart/presentation/widgets/cart_item_card.dart';
import 'package:supermarket/features/Cart/presentation/widgets/delivery_option_card.dart';
import 'package:supermarket/features/Cart/presentation/widgets/price_summary_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressesBloc>().add(const GetAddresses());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, BaseState<CartState>>(
      listener: (context, state) {
        if (state.isInitial) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              icon: CircleAvatar(
                child: Icon(Icons.done_rounded, color: Colors.white, size: 36),
                backgroundColor: Colors.green,
                radius: 30,
              ),
              title: Text(LocaleKeys.checkoutComplete.tr(context: ctx)),
              content: Text(
                LocaleKeys.checkoutCompleteMsg.tr(context: ctx),
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  spacing: UIMetrics.sm,
                  children: [
                    Flexible(
                      child: AppButton(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: AppColors.PRIMARY_COLOR,
                        title: LocaleKeys.cancel.tr(context: ctx),
                        onPress: () {
                          Navigator.pop(ctx);
                        },
                        expanded: true,
                      ),
                    ),
                    Flexible(
                      child: AppButton(
                        expanded: true,
                        title: LocaleKeys.trackOrder.tr(context: ctx),
                        onPress: () {
                          Navigator.pop(ctx, true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).then((value) {
            if (value == true) {
              context.push(AppRoutes.orders);
            }
          });
        } else if (state.isFailure) {
          showErrorSnackBar(context, state.failure?.message);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.yourCart.tr(context: context)),
            centerTitle: true,
          ),
          body: BlocBuilder<CartCubit, BaseState<CartState>>(
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingWidget();
              } else if (state.isFailure && state.item == null) {
                return Center(
                  child: ErrorView(
                    message: state.failure?.message,
                    onRetry: () {
                      context.read<CartCubit>().getCart();
                    },
                  ),
                );
              }
              return (state.item?.isEmpty ?? true)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.cart1.tr(context: context)),
                          Text(LocaleKeys.cart2.tr(context: context)),
                          const SizedBox(height: UIMetrics.lg),
                          ElevatedButton(
                            onPressed: () {
                              context.go(AppRoutes.home);
                            },
                            child: Text(
                              LocaleKeys.startShopping.tr(context: context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: UIMetrics.sm),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.item?.items.length,
                              itemBuilder: (context, index) {
                                final item = state.item?.items[index];
                                return item == null
                                    ? const SizedBox.shrink()
                                    : CartItemCard(item);
                              },
                            ),
                          ),
                          Column(
                            children: [
                              DeliveryOptionCard(state.item?.deliveryOption),
                              const SizedBox(height: UIMetrics.sm),

                              const PriceSummaryView(),

                              const SizedBox(height: UIMetrics.sm),
                              AppButton(
                                onPress: () {
                                  if (state.item?.deliveryOption != null) {
                                    context.read<CartCubit>().checkOut();
                                  } else {
                                    showErrorSnackBar(
                                      context,
                                      LocaleKeys.selectDeliveryOption.tr(
                                        context: context,
                                      ),
                                    );
                                  }
                                },
                                title: LocaleKeys.order.tr(context: context),
                                expanded: true,
                                isLoading: state.item?.isCheckingOut ?? false,
                              ),
                              const SizedBox(height: UIMetrics.sm),
                            ],
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
