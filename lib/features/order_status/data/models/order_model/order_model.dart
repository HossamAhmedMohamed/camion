import 'package:camion/features/cart/data/models/get_cart_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<GetCartModel> cartItems;
  final String shippingPrice;
  final String totalOrderPrice;
  final String paymentMethodType;
  final bool isPaid;
  final DateTime? paidAt;
  final bool isDelivered;
  final DateTime? deliveredAt;
  final String shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.cartItems,
    required this.shippingPrice,
    required this.totalOrderPrice,
    required this.paymentMethodType,
    required this.isPaid,
    this.paidAt,
    required this.isDelivered,
    this.deliveredAt,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      cartItems: (json['cartItems'] as List)
          .map((item) => GetCartModel.fromJson(item))
          .toList(),
      shippingPrice: json['shippingPrice'] ,
      totalOrderPrice: json['totalOrderPrice'] ,
      paymentMethodType: json['paymentMethodType'],
      isPaid: json['isPaid'],
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      isDelivered: json['isDelivered'],
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      shippingAddress: json['shippingAddress'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
      'shippingPrice': shippingPrice,
      'totalOrderPrice': totalOrderPrice,
      'paymentMethodType': paymentMethodType,
      'isPaid': isPaid,
      'paidAt': paidAt?.toIso8601String(),
      'isDelivered': isDelivered,
      'deliveredAt': deliveredAt?.toIso8601String(),
      'shippingAddress': shippingAddress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
