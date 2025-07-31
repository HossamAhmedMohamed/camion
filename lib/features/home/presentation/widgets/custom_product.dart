import 'package:camion/features/home/presentation/widgets/grid_item_building.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_building.dart';
import 'package:flutter/material.dart';

class ProductCarouselWidget extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int originalPrice;
  final int sellCount;
  final bool isGridView;

  const ProductCarouselWidget({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,
    required this.sellCount,
    this.isGridView = true,
  });

  @override
  State<ProductCarouselWidget> createState() => _ProductCarouselWidgetState();
}

class _ProductCarouselWidgetState extends State<ProductCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isGridView
        ? GridItemBuilding(
            imageUrl: widget.imageUrl ,
            productName: widget.productName,
            originalPrice: widget.originalPrice,
            sellCount: widget.sellCount,
          )
        : ListViewItemBuilding(
            imageUrl: widget.imageUrl,
            productName: widget.productName,
            originalPrice: widget.originalPrice,
            sellCount: widget.sellCount,
          );
  }
}
