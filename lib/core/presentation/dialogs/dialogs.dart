import 'package:flutter/material.dart';
import 'package:supermarket/core/config/constants/constants.dart';

void showNoInternetSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: kAppPadding2,
    ),
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(kAppRadius)),
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
      horizontal: kAppPadding2,
    ),
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(kAppRadius)),
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
