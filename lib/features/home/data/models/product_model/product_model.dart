import 'price.dart';
import 'pro_price.dart';

class ProductsModel {
  String spuCode;
  String productName;
  String? productLink;
  Price price;
  ProPrice? proPrice;
  String picUrl;
  String? platform;
  int sellCount;

  ProductsModel({
    required this.spuCode,
    required this.productName,
    this.productLink,
    required this.price,
    this.proPrice,
    required this.picUrl,
    this.platform,
    required this.sellCount,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    spuCode: json['spuCode'],
    productName: json['productName'],
    productLink: json['productLink'],
    price: Price.fromJson(json['price']),
    proPrice: json['proPrice'] == null
        ? null
        : ProPrice.fromJson(json['proPrice'] as Map<String, dynamic>),
    picUrl: json['picUrl'],
    platform: json['platform'],
    sellCount: json['sellCount'],
  );

  Map<String, dynamic> toJson() => {
    'spuCode': spuCode,
    'productName': productName,
    'productLink': productLink,
    'price': price.toJson(),
    'proPrice': proPrice?.toJson(),
    'picUrl': picUrl,
    'platform': platform,
    'sellCount': sellCount,
  };
}
