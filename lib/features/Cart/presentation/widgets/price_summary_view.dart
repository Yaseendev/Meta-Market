import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';

class PriceSummaryView extends StatelessWidget {
  const PriceSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, BaseState<CartState>>(
      builder: (context, state) {
        return Column(
          spacing: UIMetrics.xs,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.subtotal.tr(context: context)),
                Text(TextUtil.formatCurrency(state.item?.subtotal ?? 0)),
              ],
            ),
            if (state.item?.deliveryOption ==
                DeliveryOption.delivery /*TODO: && address not null*/ )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.deliveryFees.tr(context: context)),
                  Text(TextUtil.formatCurrency(10)),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.total.tr(context: context)),
                Text(TextUtil.formatCurrency(state.item?.total ?? 0)),
              ],
            ),
          ],
        );
      },
    );
  }
}
