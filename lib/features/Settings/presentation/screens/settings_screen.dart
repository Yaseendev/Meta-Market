import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/features/Settings/presentation/widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: UISpaces.lg),
          Assets.images.logoTransparentText.image(),
          const SizedBox(height: UISpaces.lg),
          ...ListTile.divideTiles(
            tiles: [
              SettingsTile(
                icon: Icons.person_rounded,
                title: LocaleKeys.profile.tr(context: context),
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.person_pin,
                title: LocaleKeys.addresses.tr(context: context),
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.table_view_rounded,
                title: LocaleKeys.orders.tr(context: context),
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.language,
                title: LocaleKeys.language.tr(context: context),
                onTap: () {},
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
        ],
      ),
    );
  }
}
