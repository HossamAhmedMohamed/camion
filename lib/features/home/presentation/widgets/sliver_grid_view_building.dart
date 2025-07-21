import 'package:camion/features/home/data/models/product_model.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SliverGridViewBuilding extends StatelessWidget {
  const SliverGridViewBuilding({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: screenWidth > 400 && screenWidth < 800
            ? 0.51.r
            : screenWidth > 800
            ? 0.82.r
            : 0.48.r,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 20.h,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = ProductData.products[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.productDetails, extra: product);
          },
          child: ProductCarouselWidget(
            productImages: product.productImages,
            discountImage: product.discountImage,
            productName: product.productName,
            originalPrice: product.originalPrice,
            discountedPrice: product.discountedPrice,
            rating: product.rating,
            reviewCount: product.reviewCount,
            sellCount: product.sellCount,
            isGridView: true,
          ),
        );
      }, childCount: ProductData.products.length),
    );
  }
}
