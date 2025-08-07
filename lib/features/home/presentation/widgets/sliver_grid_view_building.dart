import 'dart:developer';

import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/grid_item_skeletonizer.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverGridViewBuilding extends StatelessWidget {
  const SliverGridViewBuilding({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  getUserId() async {
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    log(userId.toString());
    return userId;
  }

  getToken() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    log(token.toString());
    return token;
  }

  Future<Map<String, String>> getUserData() async {
    final token = await getToken();
    final userId = await getUserId();
    return {'token': token, 'userId': userId};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(child: Container());
        }

        if (!asyncSnapshot.hasData) {
          return SliverToBoxAdapter(child: Container());
        }

        final userData = asyncSnapshot.data!;
        final token = userData['token'];
        final userId = userData['userId'];
        return BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 800 ? 3 : 2,
                  childAspectRatio: (0.23.w / 0.45.h).clamp(0.5, 1),
                  // mainAxisExtent: screenWidth >= 410 && screenWidth < 480
                  //     ? 380.h
                  //     : screenWidth >= 480 && screenWidth < 800
                  //     ? 430.h
                  //     : screenWidth >= 800 && screenWidth < 1000
                  //     ? 620.h
                  //     : screenWidth >= 1000
                  //     ? 680.h
                  //     : 350.h,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 10.h,
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
                  childAspectRatio: (0.23.w / 0.45.h).clamp(0.5, 1),
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 10.h,
                  // mainAxisExtent: screenWidth >= 376 && screenWidth < 410
                  //     ? 320.h
                  //     : screenWidth >= 410 && screenWidth < 480
                  //     ? 350.h
                  //     : screenWidth >= 480 && screenWidth < 800
                  //     ? 400.h
                  //     : screenWidth >= 800 && screenWidth < 1000
                  //     ? 600.h
                  //     : screenWidth >= 1000
                  //     ? 660.h
                  //     : 300.h,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.productDetails, extra: product.id.toString());
                    },
                    child: ProductCarouselWidget(
                      imageUrl: product.images[0].thumbnail,
                      productName: product.name,
                      originalPrice: product.prices.price.toString(),

                      isGridView: true,
                      onAddToCartTap: () {
                        context.read<AddCartCubit>().addToCart(
                          token: token!,
                          userId: userId!,
                          productId: product.id.toString(),
                          title: product.name,
                          price: product.prices.price.toInt(),
                          image: product.images[0].thumbnail,
                          quantity: 1,
                        );
                      },
                      onAddToWishListTap: () {},
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(state.error.icon, color: Colors.red, size: 50),

                      SizedBox(height: 20.h),
                      Text(
                        state.error.message,
                        style: TextStyle(fontSize: 16.sp, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 10.h),

                      ElevatedButton(
                        onPressed: () {
                          context.read<ProductsCubit>().retryLoadMore();
                        },
                        child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
