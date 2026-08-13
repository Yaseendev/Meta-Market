import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final bool simplified;
  const AddressCard(this.address, {super.key, this.simplified = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!simplified) {
          context.push(
            '${AppRoutes.addresses}/${AppRoutes.address}',
            extra: address,
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIMetrics.radius),
        ),
        child: ListTile(
          leading: simplified
              ? null
              : IconButton(
                  onPressed: !address.isDefault
                      ? () {
                          context.read<AddressesBloc>().add(
                            MarkAsCurrent(address),
                          );
                        }
                      : null,
                  icon: address.isDefault
                      ? Icon(
                          Icons.check_rounded,
                          color: AppColors.PRIMARY_COLOR,
                        )
                      : Container(),
                ),
          title: Text(address.details.label),
          subtitle: Text(address.details.toString()),
          trailing: simplified
              ? null
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          LocaleKeys.deleteAddress.tr(context: context),
                        ),
                        content: Text(
                          LocaleKeys.deleteAddressMsg.tr(context: context),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(LocaleKeys.delete.tr(context: context)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(LocaleKeys.cancel.tr(context: context)),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value == true) {
                        context.read<AddressesBloc>().add(
                          DeleteAddress(address),
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.delete_rounded, color: Colors.red),
                ),
        ),
      ),
    );
  }
}
