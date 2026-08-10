import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/utils/text_util.dart';
import 'package:supermarket/features/Orders/domain/entities/order.dart';
import 'package:supermarket/features/Orders/domain/enums/order_status.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
      ),
      child: ListTile(
        leading: Text(
          order.status.name.toLowerCase().tr(context: context),
          style: TextStyle(
            color: _mapStatusColor(order.status),
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text('${LocaleKeys.order.tr(context: context)}#${order.id}'),
        subtitle: Text(
          TextUtil.formatDate(order.date, context.locale.languageCode),
        ),
        trailing: Text(
          TextUtil.formatCurrency(
            order.total,
            decimalDigits: 2,
            locale: context.locale.languageCode,
          ),
        ),
      ),
    );
  }

  Color _mapStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.PROCESSING:
        return Colors.amber;
      case OrderStatus.PENDING:
        return Colors.amber;
      case OrderStatus.COMPLETED:
        return Colors.green;
      case OrderStatus.CANCELLED:
        return Colors.red;
    }
  }
}
