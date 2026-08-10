// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequestModel _$CreateOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => CreateOrderRequestModel(
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveryOption: $enumDecode(_$DeliveryOptionEnumMap, json['delivery_option']),
);

Map<String, dynamic> _$CreateOrderRequestModelToJson(
  CreateOrderRequestModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'delivery_option': _$DeliveryOptionEnumMap[instance.deliveryOption]!,
};

const _$DeliveryOptionEnumMap = {
  DeliveryOption.delivery: 'delivery',
  DeliveryOption.pickup: 'pickup',
};
