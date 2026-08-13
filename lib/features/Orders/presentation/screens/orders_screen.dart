import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/presentation/blocs/orders/orders_cubit.dart';
import 'package:supermarket/features/Orders/presentation/widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersCubit _ordersCubit = getIt<OrdersCubit>()..getOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.myOrders.tr(context: context))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIMetrics.sm),
        child: BlocBuilder<OrdersCubit, BaseState<List<Order>>>(
          bloc: _ordersCubit,
          builder: (context, state) {
            if (state.isLoading) {
              return LoadingWidget();
            } else if (state.isFailure) {
              return Center(
                child: ErrorView(
                  message: state.failure?.message,
                  onRetry: () {
                    _ordersCubit.getOrders();
                  },
                ),
              );
            } else if (state.isSuccess) {
              final orders = state.item ?? [];
              return RefreshIndicator.noSpinner(
                onRefresh: () {
                  return _ordersCubit.getOrders();
                },
                child: orders.isEmpty
                    ? Center(
                        child: Text(LocaleKeys.noOrders.tr(context: context)),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: UIMetrics.xs,
                          horizontal: UIMetrics.sm,
                        ),
                        itemCount: orders.length,
                        itemBuilder: (context, index) =>
                            OrderCard(orders[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: UIMetrics.sm),
                      ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
