import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'app.dart';
import 'core/config/environment/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await EnvironmentConfig.init();
  await EasyLocalization.ensureInitialized();
  await configureInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: const MainApp(),
    ),
  );
}
//dart run easy_localization:generate -f keys -O lib/core/presentation/translations -S assets/translations -o locale_keys.g.dart