import 'package:equatable/equatable.dart';

class GeoLocation extends Equatable {
  final int id;
  final double latitude;
  final double longitude;

  GeoLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, latitude, longitude];

  GeoLocation copyWith({double? latitude, double? longitude}) {
    return GeoLocation(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
