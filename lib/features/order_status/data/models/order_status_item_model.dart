import 'package:camion/features/order_status/presentation/widgets/order_status_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OrderStatusItemModel {
  final int index;
  final String title;
  final String subtitle;
  final DateTime? time;
  final bool isCompleted;
  final bool isActive;

  OrderStatusItemModel({
    required this.index,
    required this.title,
    required this.subtitle,
    this.time,
    required this.isCompleted,
    this.isActive = false,
  });
}

void showOrderTrackingModal(
  BuildContext context, {
  required DateTime orderConfirmingTime,
  required bool isOrderShipped,
  required bool isOrderPaied,
  required String paidSubtitle,
  required String shippedSubtitle,
}) {
  List<OrderStatusItemModel> trackingItems = [
    OrderStatusItemModel(
      index: 0,
      title: "Order Confirmed",
      subtitle: "Your order has been successfully confirmed",
      time: orderConfirmingTime,
      isCompleted: true,
    ),
    // OrderStatusItemModel(
    //   title: "خارج للتوصيل",
    //   subtitle: "",
    //   isCompleted: false,
    //   isActive: true,
    // ),
    OrderStatusItemModel(
      index: 1,
      title: "Order Paid",
      subtitle: paidSubtitle,
      isCompleted: isOrderPaied,
    ),

    OrderStatusItemModel(
      index: 2,
      title: "Order Delivered",
      subtitle: shippedSubtitle,
      // time: "",
      isCompleted: isOrderShipped,
    ),
  ];

  showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(maxHeight: double.infinity),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => OrderStatusBottomSheet(trackingItems: trackingItems),
  );
}
