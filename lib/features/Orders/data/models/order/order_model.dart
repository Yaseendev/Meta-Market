import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/enums/order_status.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: 'order_id')
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime date;
  @JsonKey(name: 'total_price')
  final num total;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  Order toDomain() => Order(id: id, date: date, total: total, status: status);
}
