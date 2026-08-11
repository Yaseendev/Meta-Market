import 'package:flutter/painting.dart' show Locale;
import 'package:intl/intl.dart';

void main() {
  print(Locale('en').languageCode);
}

class TextUtil {
  static String formatDate(DateTime date) {
    final formatter = DateFormat.yMMMd().add_jm();
    return formatter.format(date);
  }
}
