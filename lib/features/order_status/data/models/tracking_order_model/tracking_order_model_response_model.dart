class TrackingResponse {
  final int statusCode;
  final String message;
  final OrderData data;

  TrackingResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TrackingResponse.fromJson(Map<String, dynamic> json) {
    return TrackingResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  final int orderId;
  final String orderStatus;
  final List<dynamic> trackingItems;
  final int totalTracking;
  final Shipping shipping;
  final List<ShippingLine> shippingLines;

  OrderData({
    required this.orderId,
    required this.orderStatus,
    required this.trackingItems,
    required this.totalTracking,
    required this.shipping,
    required this.shippingLines,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['orderId'],
      orderStatus: json['orderStatus'],
      trackingItems: json['trackingItems'] ?? [],
      totalTracking: json['totalTracking'],
      shipping: Shipping.fromJson(json['shipping']),
      shippingLines: (json['shippingLines'] as List)
          .map((e) => ShippingLine.fromJson(e))
          .toList(),
    );
  }
}

class Shipping {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String phone;

  Shipping({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName: json['first_name'],
      lastName: json['last_name'],
      company: json['company'],
      address1: json['address_1'],
      address2: json['address_2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      phone: json['phone'],
    );
  }
}

class ShippingLine {
  final int id;
  final String methodTitle;
  final String methodId;
  final String instanceId;
  final String total;
  final String totalTax;
  final List<dynamic> taxes;
  final String taxStatus;
  final List<dynamic> metaData;

  ShippingLine({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.instanceId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.taxStatus,
    required this.metaData,
  });

  factory ShippingLine.fromJson(Map<String, dynamic> json) {
    return ShippingLine(
      id: json['id'],
      methodTitle: json['method_title'],
      methodId: json['method_id'],
      instanceId: json['instance_id'],
      total: json['total'],
      totalTax: json['total_tax'],
      taxes: json['taxes'] ?? [],
      taxStatus: json['tax_status'],
      metaData: json['meta_data'] ?? [],
    );
  }
}
