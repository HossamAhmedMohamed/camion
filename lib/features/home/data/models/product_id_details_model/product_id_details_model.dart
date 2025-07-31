import 'package:camion/features/home/data/models/product_id_details_model/product_id_price.dart';
import 'package:camion/features/home/data/models/product_id_details_model/shop.dart';

class ProductIdDetailsModel {
  final String spuCode;
  final String productName;
  final String productLink;
  final Shop shop;
  final ProductIdPrice price;
  final ProductIdPrice proPrice;
  final ProductIdPrice freight;
  final String picUrl;
  final String platform;
  final String categoryCode;
  final List<String> productImageList;

  ProductIdDetailsModel({
    required this.spuCode,
    required this.productName,
    required this.productLink,
    required this.shop,
    required this.price,
    required this.proPrice,
    required this.freight,
    required this.picUrl,
    required this.platform,
    required this.categoryCode,
    required this.productImageList,
  });

  factory ProductIdDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductIdDetailsModel(
      spuCode: json['spuCode'],
      productName: json['productName'],
      productLink: json['productLink'],
      shop: Shop.fromJson(json['shop']),
      price: ProductIdPrice.fromJson(json['price']),
      proPrice: ProductIdPrice.fromJson(json['proPrice']),
      freight: ProductIdPrice.fromJson(json['freight']),
      picUrl: json['picUrl'],
      platform: json['platform'],
      categoryCode: json['categoryCode'],
      productImageList: List<String>.from(json['productImageList']),
    );
  }
}
