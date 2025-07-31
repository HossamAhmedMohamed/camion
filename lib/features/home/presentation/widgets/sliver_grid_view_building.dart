import 'package:camion/features/home/presentation/logic/cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/grid_item_skeletonizer.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverGridViewBuilding extends StatelessWidget {
  const SliverGridViewBuilding({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 800 ? 3 : 2,
              childAspectRatio: screenWidth > 400 && screenWidth < 800
                  ? 0.51.r
                  : screenWidth > 800
                  ? 0.82.r
                  : 0.48.r,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.h,
            ),
            itemBuilder: (context, index) {
              return const Skeletonizer(
                enabled: true,
                child: GridItemBuildingSkeleton(),
              );
            },
            itemCount: 20,
          );
        }

        if (state is ProductsLoaded) {
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 800 ? 3 : 2,
              // childAspectRatio: screenWidth > 400 && screenWidth < 800
              //     ? 0.51.r
              //     : screenWidth >= 800
              //     ? 0.58.r
              //     : 0.48.r,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.h,
              mainAxisExtent: screenWidth > 470 && screenWidth < 800
                  ? 500.h
                  : screenWidth >= 800
                  ? 570.h
                  : 460.h,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).push(AppRouter.productDetails, extra: product);
                },
                child: ProductCarouselWidget(
                  imageUrl: product.picUrl,
                  productName: product.productName,
                  originalPrice: product.price.price.toInt(),
                  sellCount: product.sellCount,
                  isGridView: true,
                ),
              );
            },
            itemCount: state.products.length,
          );
        }

        if (state is ProductsError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Icon(state.error.icon, color: Colors.red, size: 50),
                  SizedBox(height: 20.h),
                  Text(
                    state.error.message,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
