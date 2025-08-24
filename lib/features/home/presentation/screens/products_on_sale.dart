import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_products_on_sale_cubit/get_products_on_sale_cubit.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsOnSaleScreen extends StatelessWidget {
  const ProductsOnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsOnSaleCubit(sl<HomeRepository>()),
        ),
        BlocProvider(
          create: (context) => AddToWishListCubit(sl<WishListRepository>()),
        ),
        BlocProvider(create: (context) => AddCartCubit(sl<CartRepository>())),
        BlocProvider(create: (context) => GetCartCubit(sl<CartRepository>())),
        BlocProvider(
          create: (context) => GetWishListCubit(sl<WishListRepository>()),
        ),
      ],
      child: const ProductsOnSaleScreenBody(),
    );
  }
}

class ProductsOnSaleScreenBody extends StatefulWidget {
  const ProductsOnSaleScreenBody({super.key});

  @override
  State<ProductsOnSaleScreenBody> createState() =>
      _ProductsOnSaleScreenBodyState();
}

class _ProductsOnSaleScreenBodyState extends State<ProductsOnSaleScreenBody> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final cubit = context.read<GetProductsOnSaleCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (cubit.hasMore && !cubit.isLoadingMore && !cubit.hasLoadMoreError) {
        cubit.getProductsOnSale(isLoadMore: true);
      }
    }
  }

  @override
  void initState() {
    context.read<GetProductsOnSaleCubit>().getProductsOnSale();
    context.read<GetWishListCubit>().getWishList();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              'Camion Offers',
              style: AppStyle.styleRegular18(context)
                  .copyWith(color: Colors.black),
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
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          BlocBuilder<GetProductsOnSaleCubit, GetProductsOnSaleState>(
            builder: (context, state) {
              if (state is GetProductsOnSaleLoading) {
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

              if (state is GetProductsOnSaleSuccess) {
                final bool isLoadingMore =
                    context.watch<GetProductsOnSaleCubit>().isLoadingMore;

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
                            productId: product.id.toString(),
                            imageUrl: product.images.isEmpty
                                ? ''
                                : product.images[0].thumbnail,
                            currencyCode: product.prices.currencyCode,
                            productName: product.name,
                            originalPrice: product.prices.price.toString(),
                            outPrice: product.prices.regularPrice.toString(),
                            isGridView: false,
                            onAddToCartTap: () {
                              // context.read<AddCartCubit>().addToCart(
                              //   productId: product.id.toString(),
                              //   quantity: 1,
                              // );
                            },
                            onAddToWishListTap: () async {
                              await context
                                  .read<AddToWishListCubit>()
                                  .addtoWishList(
                                    productId: product.id.toString(),
                                    title: product.name,
                                    price: product.prices.price,
                                    image: product.images[0].thumbnail,
                                  );

                              context.read<GetWishListCubit>().getWishList();
                                HomeScreen.homeKey.currentState
                                                  ?.refreshWishListAndCartList();
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

                    return const SizedBox.shrink();
                  },
                  itemCount: products.length + (isLoadingMore ? 2 : 0),
                );
              }
              if (state is GetProductsOnSaleError) {
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
                                .read<GetProductsOnSaleCubit>()
                                .getProductsOnSale();
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