import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverListViewBuilding extends StatelessWidget {
  const SliverListViewBuilding({super.key});

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
          final bool isLoadingMore = context
              .watch<ProductsCubit>()
              .isLoadingMore;

          final products = state.products;
          return SliverList.builder(
            itemBuilder: (context, index) {
              if (index < products.length) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.productDetails,
                        extra: product.id.toString(),
                      );
                    },
                    child: ProductCarouselWidget(
                      reviewCount: product.reviewCount.toString(),
                      averageRating: product.averageRating,
                      outPrice: product.prices.regularPrice.toString() ,
                      productId: product.id.toString(),
                      imageUrl: product.images.isEmpty?  '' : product.images[0].thumbnail  ,
                      productName: product.name,
                      originalPrice: product.prices.price.toString(),

                      isGridView: false,
                      onAddToCartTap: () {
                        // context.read<AddCartCubit>().addToCart(
                        //   productId: product.id.toString(),
                        //   title: product.name,
                        //   price: product.prices.price,
                        //   image: product.images[0].thumbnail,
                        //   quantity: 1,
                        // );
                      },
                      onAddToWishListTap: () async {
                        await context.read<AddToWishListCubit>().addtoWishList(
                          productId: product.id.toString(),
                          title: product.name,
                          price: product.prices.price,
                          image: product.images[0].thumbnail,
                        );
                        context.read<GetWishListCubit>().getWishList();
                      },
                    ),
                  ),
                );
              } else if (isLoadingMore) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: const Skeletonizer(
                    enabled: true,
                    child: ListViewItemBuildingSkeleton(),
                  ),
                );
              }
              return const SizedBox();
            },
            itemCount: state.products.length + (isLoadingMore ? 2 : 0),
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
