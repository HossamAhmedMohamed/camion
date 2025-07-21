import 'package:camion/features/home/data/models/product_model.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SliverListViewBuilding extends StatelessWidget {
  const SliverListViewBuilding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, index) {
          final product = ProductData.products[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: GestureDetector(
              onTap: (){
                GoRouter.of(context).push(AppRouter.productDetails,
                 extra: product);
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
                isGridView: false,
              ),
            ),
          );
        },
        itemCount: ProductData.products.length,
      );
  }
}
