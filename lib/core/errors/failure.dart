import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

 const Failure({
    String? message = "Something Went Wrong",
  }) : this.message = message ?? 'Something Went Wrong';

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}