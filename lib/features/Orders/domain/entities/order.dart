import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Orders/domain/enums/order_status.dart';

class Order extends Equatable {
  final int id;
  final DateTime date;
  final num total;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });

  @override
  List<Object?> get props => [id, date, total, status];
}
