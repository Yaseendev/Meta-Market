import 'package:intl/intl.dart';

void main() {
  print(TextUtil.formatCurrency(150));
}

class TextUtil {
  static String formatCurrency(
    num amount, {
    String? locale,
    int? decimalDigits,
  }) {
    // Uses IQD symbol and 0 decimal digits
    final formatter = NumberFormat.compactSimpleCurrency(
      locale: locale,
      // symbol: locale == 'en' ? 'IQD' : 'دينار',
      decimalDigits: decimalDigits ?? 0,
    );
    return formatter.format(amount);
  }
}
