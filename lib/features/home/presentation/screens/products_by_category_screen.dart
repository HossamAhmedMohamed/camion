import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_by_category_cubit/product_by_category_cubit.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';

import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key, required this.slug});
  final String slug;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductByCategoryCubit(sl<HomeRepository>()),
        ),
        BlocProvider(create: (context) => AddToWishListCubit(sl<WishListRepository>())),
        BlocProvider(create: (context) => AddCartCubit(sl<CartRepository>())),
        BlocProvider(create: (context) => GetCartCubit(sl<CartRepository>())),
        BlocProvider(create: (context) => GetWishListCubit(sl<WishListRepository>())),

      ],
      child: ProductsByCategoryScreenBody(slug: slug),
    );
  }
}

class ProductsByCategoryScreenBody extends StatefulWidget {
  const ProductsByCategoryScreenBody({super.key, required this.slug});

  final String slug;
  @override
  State<ProductsByCategoryScreenBody> createState() =>
      _ProductsByCategoryScreenBodyState();
}

class _ProductsByCategoryScreenBodyState
    extends State<ProductsByCategoryScreenBody> {
  @override
  void initState() {
    context.read<ProductByCategoryCubit>().getProductsByCategory(
      slug: widget.slug,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              widget.slug,
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: Colors.black),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
            isShownDivider: true,
            actions: const [],

            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: true,
            //   background: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.w),
            //         child: const SearchBarHome(),
            //       ),
            //     ],
            //   ),
            // ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(
            builder: (context, state) {
              if (state is ProductByCategoryLoading) {
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
                  itemCount: 10,
                );
              }

              if (state is ProductByCategoryLoaded) {
                return SliverList.builder(
                  itemBuilder: (context, index) {
                    final product = state.products[index];
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
                          productId: product.id.toString(),
                          imageUrl: product.images[0].thumbnail,
                          productName: product.name,
                          originalPrice: product.prices.price.toString(),
                          outPrice: product.prices.regularPrice,
                          isGridView: false,
                          onAddToCartTap: () {
                            // context.read<AddCartCubit>().addToCart(
                            //   productId: product.id.toString(),

                            //   quantity: 1,
                            // );
                          },
                          onAddToWishListTap: () async{
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
                  },
                  itemCount: state.products.length,
                );
              }
              if (state is ProductByCategoryError) {
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
                            context
                                .read<ProductByCategoryCubit>()
                                .getProductsByCategory(slug: widget.slug);
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverToBoxAdapter(child: Container());
            },
          ),
        ],
      ),
    );
  }
}
