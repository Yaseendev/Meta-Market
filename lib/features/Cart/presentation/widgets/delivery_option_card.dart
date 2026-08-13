import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Address/presentation/widgets/address_card.dart';
import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';

class DeliveryOptionCard extends StatelessWidget {
  final DeliveryOption? option;
  const DeliveryOptionCard(this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(UIMetrics.radius),
      ),
      child: RadioGroup<DeliveryOption>(
        onChanged: (value) {
          if (value != null) {
            context.read<CartCubit>().changeDeliveryOption(value);
          }
        },
        groupValue: option,
        child: Column(
          children: ListTile.divideTiles(
            context: context,
            tiles: DeliveryOption.values.map((e) {
              return Column(
                children: [
                  RadioListTile(
                    value: e,
                    title: Text(e.name.tr(context: context)),
                  ),
                  if (option == DeliveryOption.delivery &&
                      e == DeliveryOption.delivery)
                    BlocBuilder<AddressesBloc, BaseState<List<Address>>>(
                      builder: (context, state) {
                        if (state.isSuccess) {
                          final currentAddress = state.item?.firstWhereOrNull(
                            (element) => element.isDefault,
                          );
                          if (currentAddress != null) {
                            return AddressCard(
                              currentAddress,
                              simplified: true,
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                ],
              );
            }).toList(),
          ).toList(),
        ),
      ),
    );
  }
}
