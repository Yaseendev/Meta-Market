import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Address/presentation/widgets/address_card.dart';

class AddressesView extends StatelessWidget {
  final List<Address> addresses;
  const AddressesView(this.addresses, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.noSpinner(
      onRefresh: () {
        return Future.value(
          context.read<AddressesBloc>()..add(const GetAddresses()),
        );
      },
      child: addresses.isEmpty
          ? Center(child: Text(LocaleKeys.noAddresses.tr(context: context)))
          : ListView.separated(
            padding: const EdgeInsets.symmetric(
                vertical: UIMetrics.xs,
                horizontal: UIMetrics.sm,
              ),
              itemCount: addresses.length,
              itemBuilder: (context, index) => AddressCard(addresses[index]),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: UIMetrics.sm),
            ),
    );
  }
}
