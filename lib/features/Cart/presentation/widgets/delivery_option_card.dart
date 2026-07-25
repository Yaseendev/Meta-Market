import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';

class DeliveryOptionCard extends StatelessWidget {
  final DeliveryOption? option;
  const DeliveryOptionCard(this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RadioGroup<DeliveryOption>(
        onChanged: (value) {
          if (value != null) {
            context.read<CartCubit>().changeDeliveryOption(value);
          }
        },
        groupValue: option,
        child: Column(
          children: ListTile.divideTiles(
            tiles: DeliveryOption.values
                .map(
                  (e) => RadioListTile(
                    value: e,
                    title: Text(e.name.tr(context: context)),
                  ),
                )
                .toList(),
          ).toList(),
        ),
      ),
    );
  }
}
