import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/config/constants/urls.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';

class StaticMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  const StaticMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UIMetrics.radius),
      child: CachedNetworkImage(
        imageUrl: Urls.getStaticMapUrl(
          latitude: latitude,
          longitude: longitude,
        ),
        fit: BoxFit.fill,
        height: 200,
        width: 300,
      ),
    );
  }
}
