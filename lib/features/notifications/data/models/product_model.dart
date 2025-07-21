// أولاً نعمل الـ Model
import 'package:camion/core/utils/app_images.dart';

class ProductModel {
  final String id;
  final List<String> productImages;
  final String discountImage;
  final String productName;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final int reviewCount;
  final int sellCount;

  ProductModel({
    required this.id,
    required this.productImages,
    required this.discountImage,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.sellCount,
  });

  double get discountPercentage {
    return ((originalPrice - discountedPrice) / originalPrice) * 100;
  }

  bool get hasDiscount {
    return discountedPrice < originalPrice;
  }
}

class ProductData {
  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      productImages: [
        Assets.imagesShoes,
        Assets.imagesShoes,
        Assets.imagesShoes,
      ],
      discountImage: Assets.imagesDiscount,
      productName: 'حذاء رياضي أبيض كلاسيكي',
      originalPrice: 400,
      discountedPrice: 200,
      rating: 4.5,
      reviewCount: 128,
      sellCount: 45,
    ),
    ProductModel(
      id: '2',
      productImages: [
        Assets.imagesShoes,
        Assets.imagesShoes,
        Assets.imagesShoes,
      ],
      discountImage: Assets.imagesDiscount,
      productName: 'حذاء جري مريح للرياضة',
      originalPrice: 350,
      discountedPrice: 245,
      rating: 4.2,
      reviewCount: 89,
      sellCount: 32,
    ),
    ProductModel(
      id: '3',
      productImages: [
        Assets.imagesShoes,
        Assets.imagesShoes,
        Assets.imagesShoes,
      ],
      discountImage: Assets.imagesDiscount,
      productName: 'حذاء كاجوال عصري',
      originalPrice: 300,
      discountedPrice: 225,
      rating: 4.7,
      reviewCount: 156,
      sellCount: 67,
    ),
    ProductModel(
      id: '4',
      productImages: [
        Assets.imagesShoes,
        Assets.imagesShoes,
        Assets.imagesShoes,
      ],
      discountImage: Assets.imagesDiscount,
      productName: 'حذاء رياضي للمشي',
      originalPrice: 450,
      discountedPrice: 270,
      rating: 4.3,
      reviewCount: 201,
      sellCount: 78,
    ),
    ProductModel(
      id: '5',
      productImages: [
        Assets.imagesShoes,
        Assets.imagesShoes,
        Assets.imagesShoes,
      ],
      discountImage: Assets.imagesDiscount,
      productName: 'حذاء رياضي متعدد الألوان',
      originalPrice: 500,
      discountedPrice: 200,
      rating: 4.6,
      reviewCount: 95,
      sellCount: 23,
    ),
  ];
}
