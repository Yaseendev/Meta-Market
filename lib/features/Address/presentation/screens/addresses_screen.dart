import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/core/presentation/widgets/error_view.dart';
import 'package:supermarket/core/presentation/widgets/loading_widget.dart';
import 'package:supermarket/features/Address/domain/entities/address.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Address/presentation/widgets/addresses_view.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressesBloc>().add(const GetAddresses());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.addresses.tr(context: context))),
      body: BlocBuilder<AddressesBloc, BaseState<List<Address>>>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoadingWidget();
          } else if (state.isFailure) {
            return ErrorView(
              message: state.failure?.message,
              onRetry: () {
                context.read<AddressesBloc>().add(const GetAddresses());
              },
            );
          } else if (state.isSuccess) {
            return AddressesView(state.item ?? []);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton:
          BlocBuilder<AddressesBloc, BaseState<List<Address>>>(
            builder: (context, state) {
              return state.isSuccess
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: UIMetrics.xs,
                        horizontal: UIMetrics.sm,
                      ),
                      child: AppButton(
                        title: LocaleKeys.addAddress.tr(context: context),
                        expanded: true,
                        onPress: () {
                          context.push(
                            '${AppRoutes.addresses}/${AppRoutes.address}',
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
