import 'package:camion/features/home/data/models/all_products_model/sub_models/variation.dart';

class OrderModel {
  final String worderId;
  final String total;
  final String id;
  final String userId;
  final String currencyCode;
  final DateTime createdAt;
  final DateTime? paidAt;
  final DateTime? deliveredAt;
  final List<OrderItemModel> items;
  final String paymentMethod;
  final bool isDelivered;
  final bool isPaid;
  final CustomerDataModel? customerData; // ✅ جديد

  OrderModel({
    required this.currencyCode,
    required this.worderId,
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.paidAt,
    required this.deliveredAt,
    required this.items,
    required this.paymentMethod,
    required this.isDelivered,
    required this.isPaid,
    this.customerData,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      total: json['total'] ?? '',
      currencyCode: json['currency'] ?? '',
      worderId: json['wcOrderId'] ?? '',
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      paymentMethod: json['payment_method'] ?? '',
      isDelivered: json['isDelivered'] ?? false,
      isPaid: json['isPaid'] ?? false,
      customerData: json['customer_data'] != null
          ? CustomerDataModel.fromJson(json['customer_data'])
          : null,
    );
  }
}

class OrderItemModel {
  final String id;
  final String image;
  final String price;
  final String title;
  final String userId;
  final int quantity;
  final String productId;
  final List<Variation> variation;
  final String? couponCode;
  final int discountPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItemModel({
    required this.id,
    required this.image,
    required this.price,
    required this.title,
    required this.userId,
    required this.quantity,
    required this.productId,
    required this.variation,
    required this.couponCode,
    required this.discountPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '0',
      title: json['title'] ?? '',
      userId: json['userId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productId: json['productId'] ?? '',
      variation: (json['variation'] as List? ?? [])
          .map((v) => Variation.fromJson(v))
          .toList(),
      couponCode: json['couponCode'],
      discountPercentage: json['discountPercentage'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

/// ✅ Customer Data Model
class CustomerDataModel {
  final String city;
  final String email;
  final String phone;
  final String state;
  final String country;
  final String postcode;
  final String address1;
  final String address2;
  final String lastName;
  final String firstName;
  final ShippingOption? shippingOption;
  final ShippingAddress? shippingAddress;

  CustomerDataModel({
    required this.city,
    required this.email,
    required this.phone,
    required this.state,
    required this.country,
    required this.postcode,
    required this.address1,
    required this.address2,
    required this.lastName,
    required this.firstName,
    this.shippingOption,
    this.shippingAddress,
  });

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerDataModel(
      city: json['city'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postcode: json['postcode'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      lastName: json['last_name'] ?? '',
      firstName: json['first_name'] ?? '',
      shippingOption: json['shipping_option'] != null
          ? ShippingOption.fromJson(json['shipping_option'])
          : null,
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(json['shipping_address'])
          : null,
    );
  }
}

/// ✅ Shipping Option Model
class ShippingOption {
  final String cost;
  final String title;
  final String methodId;
  final int instanceId;

  ShippingOption({
    required this.cost,
    required this.title,
    required this.methodId,
    required this.instanceId,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) {
    return ShippingOption(
      cost: json['cost'] ?? '',
      title: json['title'] ?? '',
      methodId: json['method_id'] ?? '',
      instanceId: json['instance_id'] ?? 0,
    );
  }
}

/// ✅ Shipping Address Model
class ShippingAddress {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String address1;
  final String address2;
  final String lastName;
  final String firstName;

  ShippingAddress({
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.address1,
    required this.address2,
    required this.lastName,
    required this.firstName,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postcode: json['postcode'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      lastName: json['last_name'] ?? '',
      firstName: json['first_name'] ?? '',
    );
  }
}
