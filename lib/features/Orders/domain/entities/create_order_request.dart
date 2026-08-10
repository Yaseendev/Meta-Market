import 'package:supermarket/features/Cart/domain/enums/delivery_option.dart';
import 'package:supermarket/features/Orders/domain/entities/order_item_request.dart';

class CreateOrderRequest {
  final List<OrderItemRequest> items;
  final DeliveryOption deliveryOption;

  const CreateOrderRequest({required this.items, required this.deliveryOption});
}
