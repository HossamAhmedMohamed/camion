import 'package:camion/config/localization/cubit/localizations_cubit.dart';
import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_sub_categories/get_sub_categories_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_by_category_cubit/product_by_category_cubit.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.id,
  });
  final String slug;
  final int id;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductByCategoryCubit(sl<HomeRepository>()),
        ),
        BlocProvider(
          create: (context) => AddToWishListCubit(sl<WishListRepository>()),
        ),
        BlocProvider(create: (context) => AddCartCubit(sl<CartRepository>())),
        BlocProvider(create: (context) => GetCartCubit(sl<CartRepository>())),
        BlocProvider(
          create: (context) => GetWishListCubit(sl<WishListRepository>()),
        ),

        BlocProvider(
          create: (context) => GetSubCategoriesCubit(sl<HomeRepository>()),
        ),
      ],
      child: ProductsByCategoryScreenBody(slug: slug, id: id),
    );
  }
}

class ProductsByCategoryScreenBody extends StatefulWidget {
  const ProductsByCategoryScreenBody({
    super.key,
    required this.slug,
    required this.id,
  });

  final String slug;
  final int id;
  @override
  State<ProductsByCategoryScreenBody> createState() =>
      _ProductsByCategoryScreenBodyState();
}

class _ProductsByCategoryScreenBodyState
    extends State<ProductsByCategoryScreenBody> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final cubit = context.read<ProductByCategoryCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (cubit.hasMore && !cubit.isLoadingMore && !cubit.hasLoadMoreError) {
        cubit.getProductsByCategory(isLoadMore: true, lang: context.read<LocalizationsCubit>().state.languageCode, slug: widget.slug);
      }
    }
  }

  @override
  void initState() {
    context.read<ProductByCategoryCubit>().getProductsByCategory(
      slug: widget.slug,
      lang: context.read<LocalizationsCubit>().state.languageCode,
    );
    context.read<GetWishListCubit>().getWishList();
    context.read<GetSubCategoriesCubit>().getSubCategories(
        lang: context.read<LocalizationsCubit>().state.languageCode,
      id: widget.id);
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
    final screenWidth = MediaQuery.of(context).size.width;
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

          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<GetSubCategoriesCubit, GetSubCategoriesState>(
                  builder: (context, state) {
                    if (state is GetSubCategoriesLoading) {
                      return Row(
                        children: List.generate(6, (index) {
                          return Container(
                            margin: EdgeInsets.only(
                              right: index == 0 ? 0 : 10.w,
                            ),
                            child: Skeletonizer(
                              enabled: true,
                              child: SizedBox(
                                height: screenWidth > 800 ? 120.h : 60.h,
                                width: screenWidth > 800 ? 120.w : 60.w,
                                child: Image.asset(Assets.imagesShoes),
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    if (state is GetSubCategoriesSuccess) {
                      final categoriesWithImages = state.subCategories
                          .where(
                            (category) =>
                                category.image != null &&
                                category.image!.thumbnail.isNotEmpty,
                          )
                          .toList();

                      if (categoriesWithImages.isEmpty) {
                        return Container();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                              categoriesWithImages.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    final slug =
                                        categoriesWithImages[index].name;
                                    final id = categoriesWithImages[index].id;
                                    GoRouter.of(context).push(
                                      AppRouter.productByCategory,
                                      extra: {"slug": slug, "id": id},
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth > 800 ? 140.w : 80.w,
                                    height: screenWidth > 800 ? 140.h : 80.h,
                                    padding: EdgeInsets.all(0.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(15),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 2.h),
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.only(left: 15.w),
                                    child: SizedBox(
                                      height: screenWidth > 800 ? 120.h : 60.h,
                                      width: screenWidth > 800 ? 120.w : 60.w,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ClipOval(
                                              child: CustomCachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    categoriesWithImages[index]
                                                        .image!
                                                        .thumbnail,
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            top: 10.h,
                                            bottom: 10.h,
                                            left: 20.w,
                                            right: 20.w,
                                            child: Center(
                                              child: FittedBox(
                                                child: Text(
                                                  categoriesWithImages[index]
                                                      .name,
                                                  style:
                                                      AppStyle.styleRegular18(
                                                        context,
                                                      ).copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    }
                    if (state is GetSubCategoriesError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(state.error.icon, color: Colors.red, size: 50),

                            SizedBox(height: 20.h),
                            Text(
                              state.error.message,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10.h),

                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<GetSubCategoriesCubit>()
                                    .getSubCategories(
                                      lang: context.read<LocalizationsCubit>().state.languageCode,
                                      id: widget.id);
                              },
                              child: Text(
                                'Retry',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

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
                  itemCount: 20,
                );
              }

              if (state is ProductByCategoryLoaded) {
                final bool isLoadingMore = context
                    .watch<ProductByCategoryCubit>()
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
                            productId: product.id.toString(),
                            imageUrl: product.images.isEmpty
                                ? ''
                                : product.images[0].thumbnail,
                            currencyCode: product.prices.currencyCode,
                            currencySymbol: product.prices.currencySymbol,
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
                                .getProductsByCategory(
                                  lang: context.read<LocalizationsCubit>().state.languageCode,
                                  slug: widget.slug);
                          },
                          child: Text(
                             S.of(context).retry,
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
