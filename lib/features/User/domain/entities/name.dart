import 'package:equatable/equatable.dart';

class Name extends Equatable {
  final String first;
  final String last;

  const Name({required this.first, required this.last});
  
  @override
  List<Object?> get props => [first, last];

}
