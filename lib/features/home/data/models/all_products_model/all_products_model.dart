// all_product_model.dart
import 'package:camion/features/home/data/models/all_products_model/sub_models/add_to_cart.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/attribute.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/variation.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/prices_model.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/product_image.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/stock_availability.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/category.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/brand.dart';

class AllProductModel {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String type;
  final String variation;
  final String permalink;
  final String sku;
  final String shortDescription;
  final String description;
  final bool onSale;
  final Prices prices;
  final String priceHtml;
  final String averageRating;
  final int reviewCount;
  final List<ProductImage> images;
  final List<Category> categories;
  final List<Category> tags;
  final List<Brand> brands;
  final List<Attribute> attributes;
  final List<Variation> variations;
  final bool hasOptions;
  final bool isPurchasable;
  final bool isInStock;
  final bool isOnBackorder;
  final StockAvailability stockAvailability;
  final bool soldIndividually;
  final AddToCart addToCart;
  final bool? isInCart;
  final bool? isInwishList;

  AllProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.type,
    required this.variation,
    required this.permalink,
    required this.sku,
    required this.shortDescription,
    required this.description,
    required this.onSale,
    required this.prices,
    required this.priceHtml,
    required this.averageRating,
    required this.reviewCount,
    required this.images,
    required this.categories,
    required this.tags,
    required this.brands,
    required this.attributes,
    required this.variations,
    required this.hasOptions,
    required this.isPurchasable,
    required this.isInStock,
    required this.isOnBackorder,
    required this.stockAvailability,
    required this.soldIndividually,
    required this.addToCart,
    this.isInCart,
    this.isInwishList,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      parent: json['parent'] ?? 0,
      type: json['type'] ?? '',
      variation: json['variation'] ?? '',
      permalink: json['permalink'] ?? '',
      sku: json['sku'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      onSale: json['on_sale'] ?? false,
      prices: Prices.fromJson(json['prices'] ?? {}),
      priceHtml: json['price_html'] ?? '',
      averageRating: json['average_rating'] ?? '0',
      reviewCount: json['review_count'] ?? 0,
      images: (json['images'] as List? ?? [])
          .map((img) => ProductImage.fromJson(img))
          .toList(),
      categories: (json['categories'] as List? ?? [])
          .map((c) => Category.fromJson(c))
          .toList(),
      tags: (json['tags'] as List? ?? [])
          .map((t) => Category.fromJson(t))
          .toList(),
      brands: (json['brands'] as List? ?? [])
          .map((b) => Brand.fromJson(b))
          .toList(),
      attributes: (json['attributes'] as List? ?? [])
          .map((a) => Attribute.fromJson(a))
          .toList(),
      variations: (json['variations'] as List? ?? [])
          .map((v) => Variation.fromJson(v))
          .toList(),
      hasOptions: json['has_options'] ?? false,
      isPurchasable: json['is_purchasable'] ?? false,
      isInStock: json['is_in_stock'] ?? false,
      isOnBackorder: json['is_on_backorder'] ?? false,
      stockAvailability:
          StockAvailability.fromJson(json['stock_availability'] ?? {}),
      soldIndividually: json['sold_individually'] ?? false,
      addToCart: AddToCart.fromJson(json['add_to_cart'] ?? {}),
      isInCart: json['cart'],
      isInwishList: json['wishlist'],
    );
  }
}
