import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Settings/presentation/widgets/language_list_view.dart';
import 'package:supermarket/features/Settings/presentation/widgets/settings_tile.dart';
import 'package:supermarket/features/User/presentation/blocs/delete_profile/delete_profile_cubit.dart';
import 'package:supermarket/features/User/presentation/blocs/profile/profile_cubit.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final DeleteProfileCubit _deleteProfileCubit = getIt<DeleteProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteProfileCubit, BaseState>(
      bloc: _deleteProfileCubit,
      listener: (context, state) {
        if (state.isSuccess) {
          getIt<ProfileCubit>().reset();
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: UIMetrics.sm,
            vertical: UIMetrics.md,
          ),
          children: [
            const SizedBox(height: UIMetrics.md),
            Assets.images.logoTransparentText.image(height: 250, width: 200),
            const SizedBox(height: UIMetrics.xs),
            ...ListTile.divideTiles(
              context: context,
              tiles: [
                SettingsTile(
                  icon: Icons.person_rounded,
                  title: LocaleKeys.profile.tr(context: context),
                  onTap: () {
                    context.push(AppRoutes.profile);
                  },
                ),
                SettingsTile(
                  icon: Icons.person_pin,
                  title: LocaleKeys.addresses.tr(context: context),
                  onTap: () {
                    context.push(
                      AppRoutes.addresses,
                      extra: context.read<AddressesBloc>(),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.table_view_rounded,
                  title: LocaleKeys.orders.tr(context: context),
                  onTap: () {
                    context.push(AppRoutes.orders);
                  },
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: LocaleKeys.language.tr(context: context),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      constraints: const BoxConstraints(
                        minWidth: 650,
                        maxWidth: 650,
                      ),
                      showDragHandle: true,
                      builder: (context) => LanguageListView(),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.person_remove_rounded,
                  title: LocaleKeys.deleteAccount.tr(context: context),
                  onTap: () {},
                ),
                SettingsTile(
                  icon: Icons.logout,
                  title: LocaleKeys.logout.tr(context: context),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: UIMetrics.md),
          ],
        ),
      ),
    );
  }
}
