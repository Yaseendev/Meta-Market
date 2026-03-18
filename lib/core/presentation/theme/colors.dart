import 'package:flutter/material.dart';

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF0E5AA7);
  //static const Color SECONDARY_COLOR = Color(0xFFE9EFF5);
  static const Color SECONDARY_COLOR = Color(0xFF669FD7);
  static const Color BACKGROUND_COLOR = Color(0xFFF7F8F9);

  static final MaterialColor PRIMARY_SWATCH =
      MaterialColor(PRIMARY_COLOR.value, <int, Color>{
    50: PRIMARY_COLOR.withOpacity(.1),
    100: PRIMARY_COLOR.withOpacity(.2),
    200: PRIMARY_COLOR.withOpacity(.3),
    300: PRIMARY_COLOR.withOpacity(.4),
    400: PRIMARY_COLOR.withOpacity(.5),
    500: PRIMARY_COLOR.withOpacity(.6),
    600: PRIMARY_COLOR.withOpacity(.7),
    700: PRIMARY_COLOR.withOpacity(.8),
    800: PRIMARY_COLOR.withOpacity(.9),
    900: PRIMARY_COLOR.withOpacity(1),
  });

    static final Gradient gradinat = LinearGradient(
    colors: [
      PRIMARY_COLOR,
      SECONDARY_COLOR,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
