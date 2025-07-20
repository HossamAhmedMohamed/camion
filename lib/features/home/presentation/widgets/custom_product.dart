import 'package:camion/features/home/presentation/widgets/grid_item_building.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_building.dart';
import 'package:flutter/material.dart';

class ProductCarouselWidget extends StatefulWidget {
  final List<String> productImages;
  final String discountImage;
  final String productName;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final int reviewCount;
  final int sellCount;
  final bool isGridView; // Add this parameter

  const ProductCarouselWidget({
    super.key,
    required this.productImages,
    required this.discountImage,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.sellCount,
    this.isGridView = true,
  });

  @override
  State<ProductCarouselWidget> createState() => _ProductCarouselWidgetState();
}

class _ProductCarouselWidgetState extends State<ProductCarouselWidget> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return widget.isGridView
        ? GridItemBuilding(
            productImages: widget.productImages,
            discountImage: widget.discountImage,
            productName: widget.productName,
            originalPrice: widget.originalPrice,
            discountedPrice: widget.discountedPrice,
            rating: widget.rating,
            reviewCount: widget.reviewCount,
            sellCount: widget.sellCount,
          )
        : ListViewItemBuilding(
            pageController: pageController,
            productImages: widget.productImages,
            discountImage: widget.discountImage,
            productName: widget.productName,
            originalPrice: widget.originalPrice,
            discountedPrice: widget.discountedPrice,
            rating: widget.rating,
            reviewCount: widget.reviewCount,
            sellCount: widget.sellCount,
            isGridView: widget.isGridView,
          );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
