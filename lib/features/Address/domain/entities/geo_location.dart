import 'package:equatable/equatable.dart';

class GeoLocation extends Equatable {
  final double latitude;
  final double longitude;

  GeoLocation({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];

  GeoLocation copyWith({double? latitude, double? longitude}) {
    return GeoLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
