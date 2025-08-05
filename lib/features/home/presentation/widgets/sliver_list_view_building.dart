import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverListViewBuilding extends StatelessWidget {
  const SliverListViewBuilding({super.key});

  getUserId() async {
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');

    return userId;
  }

  getToken() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    return token;
  }

  Future<Map<String, String>> getUserData() async {
    final token = await getToken();
    final userId = await getUserId();
    return {'token': token!, 'userId': userId!};
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const Skeletonizer(
                  enabled: true,
                  child: ListViewItemBuildingSkeleton(),
                ),
              );
            },
            itemCount: 20,
          );
        }

        if (state is ProductsLoaded) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).push(AppRouter.productDetails, extra: product.spuCode);
                  },
                  child: ProductCarouselWidget(
                    imageUrl: product.picUrl,
                    productName: product.productName,
                    originalPrice: product.price.price.toInt(),
                    sellCount: product.sellCount,
                    isGridView: false,
                    onAddToCartTap: () async {
                      final userData = await getUserData();
                      context.read<AddCartCubit>().addToCart(
                        token: userData['token']!,
                        userId: userData['userId']!,
                        productId: product.spuCode,
                        title: product.productName,
                        price: product.price.price.toInt(),
                        image: product.picUrl,
                        quantity: 1,
                      );
                    },
                    onAddToWishListTap: () async {
                      final userData = await getUserData();
                      final token = userData['token'];
                      final userId = userData['userId'];
                      context.read<AddToWishListCubit>().addtoWishList(
                        token: token!,
                        userId: userId!,
                        productId: product.spuCode,
                        title: product.productName,
                        price: product.price.price.toInt(),
                        image: product.picUrl,
                      );
                    },
                  ),
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
  }
}
