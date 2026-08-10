import 'package:intl/intl.dart';

void main() {
  print(TextUtil.formatDate(DateTime.now()));
}

class TextUtil {
  static String formatDate(DateTime date) {
    final formatter = DateFormat.yMMMd().add_jm();
    return formatter.format(date);
  }
}
