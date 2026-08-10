// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: (json['order_id'] as num).toInt(),
  date: DateTime.parse(json['created_at'] as String),
  total: json['total_price'] as num,
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'order_id': instance.id,
      'created_at': instance.date.toIso8601String(),
      'total_price': instance.total,
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.PENDING: 'PENDING',
  OrderStatus.COMPLETED: 'COMPLETED',
  OrderStatus.PROCESSING: 'PROCESSING',
  OrderStatus.CANCELLED: 'CANCELLED',
};
