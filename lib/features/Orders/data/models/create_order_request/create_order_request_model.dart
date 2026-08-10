import 'package:json_annotation/json_annotation.dart';
import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Orders/data/models/order_item_request/order_item_request_model.dart';

part 'create_order_request_model.g.dart';

@JsonSerializable()
class CreateOrderRequestModel {
  final List<OrderItemRequestModel> items;
  @JsonKey(name: 'delivery_option')
  final DeliveryOption deliveryOption;

  const CreateOrderRequestModel({
    required this.items,
    required this.deliveryOption,
  });

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderRequestModelToJson(this);
}
