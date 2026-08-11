import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/features/Settings/presentation/blocs/language/language_cubit.dart';

class LanguageListView extends StatelessWidget {
  LanguageListView({super.key});

  final LanguageCubit _languageCubit = getIt<LanguageCubit>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UIMetrics.sm,
        vertical: UIMetrics.xs,
      ),
      child: BlocBuilder<LanguageCubit, Locale>(
        bloc: _languageCubit,
        builder: (ctx, state) {
          return RadioGroup<Locale>(
            groupValue: state,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: context.supportedLocales
                    .map(
                      (locale) => RadioListTile<Locale>(
                        value: locale,
                        title: Text(locale.languageCode.tr(context: context)),
                      ),
                    )
                    .toList(),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                _languageCubit.changeLanguage(value.languageCode);
                Navigator.of(ctx).pop();
              }
            },
          );
        },
      ),
    );
  }
}
