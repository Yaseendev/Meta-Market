import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final String imageUrl;
  final String? id;
  final String? targetUrl;

  const Banner({required this.imageUrl, required this.id, this.targetUrl});

  @override
  List<Object?> get props => [imageUrl, id, targetUrl];
}
