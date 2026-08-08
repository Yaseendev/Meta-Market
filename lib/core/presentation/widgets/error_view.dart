import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;
  const ErrorView({super.key, this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UIMetrics.lg,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message ?? LocaleKeys.errorMsg.tr(context: context)),
        ElevatedButton(
          onPressed: onRetry,
          child: Text(LocaleKeys.retry.tr(context: context)),
        ),
      ],
    );
  }
}
