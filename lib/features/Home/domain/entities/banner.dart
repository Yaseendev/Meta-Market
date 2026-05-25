import 'package:equatable/equatable.dart';

class Banner extends Equatable{
  final String imageUrl;
  final String? id;

  const Banner({required this.imageUrl, required this.id});
  
  @override
  List<Object?> get props => [imageUrl, id];
}
