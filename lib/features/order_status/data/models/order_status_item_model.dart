import 'package:camion/features/order_status/presentation/widgets/order_status_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OrderStatusItemModel {
  final String title;
  final String subtitle;
  final String? time;
  final bool isCompleted;
  final bool isActive;

  OrderStatusItemModel({
    required this.title,
    required this.subtitle,
    this.time,
    required this.isCompleted,
    this.isActive = false,
  });
}

void showOrderTrackingModal(BuildContext context) {
  List<OrderStatusItemModel> trackingItems = [
    OrderStatusItemModel(
      title: "تم تأكيد الطلب",
      subtitle: "لقد تم تأكيد طلبك بنجاح",
      time: "05:00 PM",
      isCompleted: true,
    ),
    OrderStatusItemModel(
      title: "تم شحن الطلب",
      subtitle: "لقد تم شحن الطلب الى الفاهرة",
      time: "05:00 PM",
      isCompleted: true,
    ),
    OrderStatusItemModel(
      title: "خارج للتوصيل",
      subtitle: "",
      isCompleted: false,
      isActive: true,
    ),
    OrderStatusItemModel(
      title: "تم تسليم الطلب",
      subtitle: "",
      isCompleted: false,
    ),
  ];

  showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(maxHeight: double.infinity),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) =>
        OrderStatusBottomSheet(trackingItems: trackingItems),
  );
}