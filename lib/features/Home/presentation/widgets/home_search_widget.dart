import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: UISpaces.xs,
      children: [
        Expanded(
          child: SearchField(
            suggestions: [],
            // searchInputDecoration: SearchInputDecoration(
            //   hintText: 'Search',
            //   hintStyle: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ),
      ),
        IconButton.filled(
          onPressed: () {},
          icon: Icon(Icons.qr_code_scanner_rounded),
          padding: const EdgeInsets.all(12),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UISpaces.radius),
            ),
          ),
        ),
      ],
    );
  }
}
