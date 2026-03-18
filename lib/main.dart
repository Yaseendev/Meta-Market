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
  await configureInjection();
  runApp(const MainApp());
}
