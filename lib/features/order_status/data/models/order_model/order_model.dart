class OrderModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
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
  final List<dynamic> variation;
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
      variation: json['variation'] ?? [],
      couponCode: json['couponCode'],
      discountPercentage: json['discountPercentage'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
