import 'package:intl/intl.dart';

class TextUtil {
  static String formatCurrency(
    num amount, {
    String? locale,
    int? decimalDigits,
  }) {
    // Uses IQD symbol and 0 decimal digits
    final formatter = NumberFormat.compactSimpleCurrency(
      locale: locale,
      decimalDigits: decimalDigits ?? 2,
    );
    return formatter.format(amount);
  }

  static String formatDate(DateTime date, [String? locale]) {
    final formatter = DateFormat.yMMMd(locale).add_jm();
    return formatter.format(date);
  }
}
