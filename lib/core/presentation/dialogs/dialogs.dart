import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';

void showNoInternetSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: UISpaces.md,
    ),
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(UISpaces.radius)),
    content: Row(
      children: [
        Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Text('No Internet Connection'),
      ],
    ),
  ));
}

void showErrorSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: UISpaces.md,
    ),
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(UISpaces.radius)),
    content: Row(
      children: [
        Icon(
          Icons.error_rounded,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Flexible(child: Text(error)),
      ],
    ),
  ));
}
