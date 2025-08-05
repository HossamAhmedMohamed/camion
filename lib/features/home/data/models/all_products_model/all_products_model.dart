import 'package:camion/features/home/data/models/all_products_model/sub_models/add_to_cart.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/attributes.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/prices_model.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/product_image.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/stock_availability.dart';

class AllProductModel {
  final int id;
  final String name;
  final String slug;
  final String type;
  final String permalink;
  final String sku;
  final bool onSale;
  final Prices prices;
   
  final String averageRating;
  final int reviewCount;
  final List<ProductImage> images;
  final List<Variation> variations;
  final bool hasOptions;
  final bool isPurchasable;
  final bool isInStock;
  final bool isOnBackorder;
  final StockAvailability stockAvailability;
  final bool soldIndividually;
  final AddToCart addToCart;

  AllProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    required this.permalink,
    required this.sku,
    required this.onSale,
    required this.prices,
     
    required this.averageRating,
    required this.reviewCount,
    required this.images,
    required this.variations,
    required this.hasOptions,
    required this.isPurchasable,
    required this.isInStock,
    required this.isOnBackorder,
    required this.stockAvailability,
    required this.soldIndividually,
    required this.addToCart,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      type: json['type'],
      permalink: json['permalink'],
      sku: json['sku'],
      onSale: json['on_sale'],
      prices: Prices.fromJson(json['prices']),
     
      averageRating:  json['average_rating'], 
      reviewCount: json['review_count'],
      images: (json['images'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      variations: (json['variations'] as List)
          .map((v) => Variation.fromJson(v))
          .toList(),
      hasOptions: json['has_options'],
      isPurchasable: json['is_purchasable'],
      isInStock: json['is_in_stock'],
      isOnBackorder: json['is_on_backorder'],
      stockAvailability: StockAvailability.fromJson(json['stock_availability']),
      soldIndividually: json['sold_individually'],
      addToCart: AddToCart.fromJson(json['add_to_cart']),
    );
  }
}












