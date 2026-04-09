import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // spacing: kSmallPadding,
      children: [
        SearchField(
          suggestions: [],
        ),
        IconButton.filled(onPressed: () {}, icon: Icon(Icons.qr_code_scanner_rounded)),
      ],
    );
  }
}
