import 'package:camion/features/home/data/models/all_products_model/sub_models/variation.dart';

class GetCartModel {
  String? id;
  String? userId;
  String? productId;
  int? quantity;
  List<Variation>? variation;
  String? title;
  String? image;
  String? price;
  dynamic couponCode;
  int? discountPercentage;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? totalPrice;

  GetCartModel({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.variation,
    this.title,
    this.image,
    this.price,
    this.couponCode,
    this.discountPercentage,
    this.createdAt,
    this.updatedAt,
    this.totalPrice,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    productId: json['productId'] as String?,
    quantity: json['quantity'] as int?,
    variation: (json['variations'] as List? ?? [])
        .map((v) => Variation.fromJson(v))
        .toList(),
    title: json['title'] as String?,
    image: json['image'] as String?,
    price: json['price']?.toString(),
    couponCode: json['couponCode'],
    discountPercentage: json['discountPercentage'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  );
}
