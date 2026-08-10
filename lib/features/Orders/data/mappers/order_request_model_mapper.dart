import 'package:supermarket/features/Orders/data/models/create_order_request/create_order_request_model.dart';
import 'package:supermarket/features/Orders/data/models/order_item_request/order_item_request_model.dart';
import 'package:supermarket/features/Orders/domain/entities/create_order_request.dart';
import 'package:supermarket/features/Orders/domain/entities/order_item_request.dart';

extension OrderRequestModelMapper on CreateOrderRequestModel {
  CreateOrderRequest toDomain() {
    return CreateOrderRequest(
      items: items.map((item) => item.toDomain()).toList(),
      deliveryOption: deliveryOption,
    );
  }
}

extension OrderRequestMapper on CreateOrderRequest {
  CreateOrderRequestModel toModel() {
    return CreateOrderRequestModel(
      items: items.map((item) => item.toModel()).toList(),
      deliveryOption: deliveryOption,
    );
  }
}

extension OrderItemRequestModelMapper on OrderItemRequestModel {
  OrderItemRequest toDomain() {
    return OrderItemRequest(productId: productId, quantity: quantity);
  }
}

extension OrderItemRequestMapper on OrderItemRequest {
  OrderItemRequestModel toModel() {
    return OrderItemRequestModel(productId: productId, quantity: quantity);
  }
}