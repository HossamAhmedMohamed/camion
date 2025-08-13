class OrderResponse {
  final int status;
  final String message;
  final OrderData data;

  OrderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: OrderData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class OrderData {
  final String sessionId;
  final String stripeCheckoutUrl;
  final String orderId;
  final Order order;

  OrderData({
    required this.sessionId,
    required this.stripeCheckoutUrl,
    required this.orderId,
    required this.order,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      sessionId: json['sessionId'] ?? '',
      stripeCheckoutUrl: json['stripeCheckoutUrl'] ?? '',
      orderId: json['orderId'] ?? '',
      order: Order.fromJson(json['order'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'stripeCheckoutUrl': stripeCheckoutUrl,
      'orderId': orderId,
      'order': order.toJson(),
    };
  }
}

class Order {
  final String id;
  final int wcOrderId;
  final String wcOrderKey;
  final String wcOrderStatus;
  final String wcPaymentStatus;
  final String currency;
  final String total;
  final String userId;
  final List<OrderItem> items;
  final CustomerData customerData;
  final String paymentMethod;
  final List<dynamic> paymentData;
  final bool isPaid;
  final String? paidAt;
  final bool isDelivered;
  final String? deliveredAt;
  final String stripeSessionId;
  final String stripeCheckoutUrl;
  final String createdAt;
  final String updatedAt;

  Order({
    required this.id,
    required this.wcOrderId,
    required this.wcOrderKey,
    required this.wcOrderStatus,
    required this.wcPaymentStatus,
    required this.currency,
    required this.total,
    required this.userId,
    required this.items,
    required this.customerData,
    required this.paymentMethod,
    required this.paymentData,
    required this.isPaid,
    required this.paidAt,
    required this.isDelivered,
    required this.deliveredAt,
    required this.stripeSessionId,
    required this.stripeCheckoutUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id']?.toString() ?? '',
      wcOrderId: json['wcOrderId'] ?? 0,
      wcOrderKey: json['wcOrderKey']?.toString() ?? '',
      wcOrderStatus: json['wcOrderStatus']?.toString() ?? '',
      wcPaymentStatus: json['wcPaymentStatus']?.toString() ?? '',
      currency: json['currency']?.toString() ?? '',
      total: json['total']?.toString() ?? '', // ✅ تحويل لـ String
      userId: json['userId']?.toString() ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      customerData: CustomerData.fromJson(json['customerData'] ?? {}),
      paymentMethod: json['paymentMethod'] ?? '',
      paymentData: json['paymentData'] ?? [],
      isPaid: json['isPaid'] ?? false,
      paidAt: json['paidAt'],
      isDelivered: json['isDelivered'] ?? false,
      deliveredAt: json['deliveredAt'],
      stripeSessionId: json['stripeSessionId'] ?? '',
      stripeCheckoutUrl: json['stripeCheckoutUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wcOrderId': wcOrderId,
      'wcOrderKey': wcOrderKey,
      'wcOrderStatus': wcOrderStatus,
      'wcPaymentStatus': wcPaymentStatus,
      'currency': currency,
      'total': total,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'customerData': customerData.toJson(),
      'paymentMethod': paymentMethod,
      'paymentData': paymentData,
      'isPaid': isPaid,
      'paidAt': paidAt,
      'isDelivered': isDelivered,
      'deliveredAt': deliveredAt,
      'stripeSessionId': stripeSessionId,
      'stripeCheckoutUrl': stripeCheckoutUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class OrderItem {
  final String id;
  final String userId;
  final String productId;
  final int quantity;
  final List<dynamic> variation;
  final String title;
  final String image;
  final String price;
  final String? couponCode;
  final int discountPercentage;
  final String createdAt;
  final String updatedAt;

  OrderItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.variation,
    required this.title,
    required this.image,
    required this.price,
    required this.couponCode,
    required this.discountPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '', // ✅ تحويل لـ String
      quantity: json['quantity'] ?? 0,
      variation: json['variation'] ?? [],
      title: json['title']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: json['price']?.toString() ?? '', // ✅ تحويل لـ String
      couponCode: json['couponCode']?.toString(),
      discountPercentage: json['discountPercentage'] ?? 0,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'variation': variation,
      'title': title,
      'image': image,
      'price': price,
      'couponCode': couponCode,
      'discountPercentage': discountPercentage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CustomerData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final ShippingAddress shippingAddress;
  final ShippingOption shippingOption;

  CustomerData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.shippingAddress,
    required this.shippingOption,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      shippingAddress: ShippingAddress.fromJson(json['shipping_address'] ?? {}),
      shippingOption: ShippingOption.fromJson(json['shipping_option'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
      'shipping_address': shippingAddress.toJson(),
      'shipping_option': shippingOption.toJson(),
    };
  }
}

class ShippingAddress {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;

  ShippingAddress({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }
}

class ShippingOption {
  final String methodId;
  final String methodTitle;
  final String cost;

  ShippingOption({
    required this.methodId,
    required this.methodTitle,
    required this.cost,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) {
    return ShippingOption(
      methodId: json['method_id']?.toString() ?? '',
      methodTitle: json['method_title']?.toString() ?? '',
      cost: json['cost']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'method_id': methodId, 'method_title': methodTitle, 'cost': cost};
  }
}
