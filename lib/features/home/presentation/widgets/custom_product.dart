import 'package:camion/features/home/presentation/widgets/grid_item_building.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_building.dart';
import 'package:flutter/material.dart';

class ProductCarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String originalPrice;
  final String productId;
  final bool isGridView;
  final VoidCallback onAddToCartTap;
  final VoidCallback onAddToWishListTap;
  final String outPrice;
  final String averageRating;
  final String reviewCount;

  const ProductCarouselWidget({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,
    required this.productId,
    this.isGridView = true,
    required this.onAddToCartTap,
    required this.onAddToWishListTap,
    required this.outPrice,
    required this.averageRating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? GridItemBuilding(
            imageUrl: imageUrl,
            productName: productName,
            originalPrice: originalPrice,
            productId: productId,
            averageRating: averageRating,
            reviewCount: reviewCount,
            outPrice: outPrice,
            onTap: onAddToCartTap,
          )
        : ListViewItemBuilding(
          reviewCount: reviewCount,
          outPrice: outPrice,
            imageUrl: imageUrl,
            productName: productName,
            originalPrice: originalPrice,
            productId: productId,
            onAddToCartTap: onAddToCartTap,
            onAddToWishListTap: onAddToWishListTap,
            averageRating: averageRating,
          );
  }
}
