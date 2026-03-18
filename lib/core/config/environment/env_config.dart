import 'package:flutter_dotenv/flutter_dotenv.dart';

//For build-time and remote configurations
class EnvironmentConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String getValue(String key) => dotenv.env[key] ?? '';
  
  //URLs
  static String get baseUrl => getValue('BASE_URL');
}
