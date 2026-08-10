import 'package:easy_localization/easy_localization.dart' as w;
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Address/presentation/widgets/static_map_widget.dart';

class LocationWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  const LocationWidget({
    super.key,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Go to map screen
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.BORDER_COLOR),
          borderRadius: BorderRadius.circular(UIMetrics.radius),
        ),
        child: latitude != null && longitude != null ? StaticMapWidget(
          latitude: latitude!,
          longitude: longitude!,
        ) : Column(
          children: [
            const SizedBox(height: UIMetrics.lg),
            Icon(Icons.add_location_rounded),
            const SizedBox(height: UIMetrics.lg),
            Text(LocaleKeys.locationOnMap.tr(context: context)),
            const SizedBox(height: UIMetrics.lg),
          ],
        ),
      ),
    );
  }
}
