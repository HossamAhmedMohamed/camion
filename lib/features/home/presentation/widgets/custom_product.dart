import 'package:camion/features/home/presentation/widgets/grid_item_building.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_building.dart';
import 'package:flutter/material.dart';

class ProductCarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String originalPrice;
   
  final bool isGridView;
  final VoidCallback onAddToCartTap;
  final VoidCallback onAddToWishListTap;

  const ProductCarouselWidget({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,
   
    this.isGridView = true,
    required this.onAddToCartTap,
    required this.onAddToWishListTap,
  });

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? GridItemBuilding(
            imageUrl: imageUrl,
            productName: productName,
            originalPrice: originalPrice,
           
            onTap: onAddToCartTap,
          )
        : ListViewItemBuilding(
            imageUrl: imageUrl,
            productName: productName,
            originalPrice: originalPrice,
           
            onAddToCartTap: onAddToCartTap,
            onAddToWishListTap: onAddToWishListTap,
          );
  }
}
