import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_id_detailscubit/product_id_details_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/home/presentation/widgets/product_id_image_skeletonizer.dart';
import 'package:camion/features/home/presentation/widgets/products_options.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});

  final String productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final pageController = PageController();

  @override
  void initState() {
    BlocProvider.of<ProductIdDetailsCubit>(
      context,
    ).getProductDetails(widget.productId);
    BlocProvider.of<GetWishListCubit>(context).getWishList();
    super.initState();
    BlocProvider.of<GetCartCubit>(context).getCart();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // late AllProductModel prodcut;

  Map<String, String> chosenAttributes = {};
  int chosenQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductIdDetailsCubit>(
            context,
          ).getProductDetails(widget.productId, forceRefresh: true);
        },
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              appBarHeight: 70.h,
              title: Text(
                "Product Details",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              leading: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),

              isShownDivider: true,
            ),

            SliverToBoxAdapter(child: SizedBox(height: 15.h)),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocBuilder<ProductIdDetailsCubit, ProductIdDetailsState>(
                      builder: (context, state) {
                        if (state is ProductIdDetailsLoading) {
                          return const Skeletonizer(
                            enabled: true,
                            child: ProductImageSkeleton(),
                          );
                        }

                        if (state is ProductIdDetailsLoaded) {
                          return Stack(
                            children: [
                              PageView.builder(
                                controller: pageController,
                                onPageChanged: (index) {
                                  context
                                      .read<ToggleProductIdImagesCubit>()
                                      .toggle(index);
                                },
                                itemCount:
                                    state.productIdDetailsModel.images.length,
                                itemBuilder: (context, index) {
                                  return CustomCachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: state
                                        .productIdDetailsModel
                                        .images[index]
                                        .thumbnail,
                                  );
                                },
                              ),

                              Positioned(
                                left: 16.w,
                                top: 16.h,
                                child: BlocBuilder<GetWishListCubit, GetWishListState>(
                                  builder: (context, wishListState) {
                                    return BlocBuilder<
                                      ProductIdDetailsCubit,
                                      ProductIdDetailsState
                                    >(
                                      builder: (context, productState) {
                                        if (productState
                                            is! ProductIdDetailsLoaded) {
                                          return Container();
                                        }

                                        final product =
                                            productState.productIdDetailsModel;
                                        bool isInWishList = false;

                                        if (wishListState
                                            is GetWishListSuccess) {
                                          isInWishList = wishListState.wishLists
                                              .any(
                                                (item) =>
                                                    item.productId ==
                                                    widget.productId,
                                              );
                                        } else {
                                          isInWishList =
                                              product.isInwishList ?? false;
                                        }

                                        return InkWell(
                                          onTap: () async {
                                            if (isInWishList) {
                                              await context
                                                  .read<GetWishListCubit>()
                                                  .removeFromWishList(
                                                    productId: widget.productId,
                                                  );

                                              context
                                                  .read<GetWishListCubit>()
                                                  .getWishList();

                                              WishListScreen
                                                  .wishListKey
                                                  .currentState
                                                  ?.refreshGetWishList();
                                              HomeScreen.homeKey.currentState
                                                  ?.refreshWishListAndCartList();
                                            } else {
                                              await context
                                                  .read<AddToWishListCubit>()
                                                  .addtoWishList(
                                                    productId: product.id
                                                        .toString(),
                                                    title: product.name,
                                                    price: product.prices.price,
                                                    image: product
                                                        .images[0]
                                                        .thumbnail,
                                                  );

                                              context
                                                  .read<GetWishListCubit>()
                                                  .getWishList();
                                              WishListScreen
                                                  .wishListKey
                                                  .currentState
                                                  ?.refreshGetWishList();
                                              HomeScreen.homeKey.currentState
                                                  ?.refreshWishListAndCartList();
                                            }
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withAlpha(
                                                    15,
                                                  ),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2.h),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                isInWishList
                                                    ? Assets
                                                          .imagesIconsNewwwActiveHeart
                                                    : Assets
                                                          .imagesIconsNewwwInactiveHeart,
                                                width: 25.w,
                                                height: 25.h,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                              Positioned(
                                right: 6.w,
                                bottom: 6.h,
                                child: InkWell(
                                  onTap: () {
                                    final productLink =
                                        state.productIdDetailsModel.permalink;
                                    Share.share(
                                      productLink,
                                      subject: state.productIdDetailsModel.name,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    Assets.imagesShareProduct,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        if (state is ProductIdDetailsError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  state.error.icon,
                                  color: Colors.red,
                                  size: 50,
                                ),

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
                                        .read<ProductIdDetailsCubit>()
                                        .getProductDetails(widget.productId);
                                    ();
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

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        BlocBuilder<
                          ProductIdDetailsCubit,
                          ProductIdDetailsState
                        >(
                          builder: (context, state) {
                            if (state is ProductIdDetailsLoading) {
                              return const Skeletonizer(
                                enabled: true,
                                child: ProductInfoSkeleton(),
                              );
                            }
                            if (state is ProductIdDetailsLoaded) {
                              final product = state.productIdDetailsModel;
                              return Column(
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        state
                                            .productIdDetailsModel
                                            .images
                                            .length,
                                        (index) =>
                                            BlocBuilder<
                                              ToggleProductIdImagesCubit,
                                              ToggleProductIdImagesState
                                            >(
                                              builder: (context, state) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                  ),
                                                  width: state.index == index
                                                      ? 20.w
                                                      : 8.w,
                                                  height: 8.h,
                                                  decoration: BoxDecoration(
                                                    color: state.index == index
                                                        ? const Color(
                                                            0xFFD32F2F,
                                                          )
                                                        : Colors.grey.shade400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4.r,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.productIdDetailsModel.name,
                                          style: AppStyle.styleBold18(context),
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ),

                                      // SizedBox(width: 8.w),
                                    ],
                                  ),

                                  SizedBox(height: 8.h),

                                  Row(
                                    children: [
                                      Text(
                                        state
                                            .productIdDetailsModel
                                            .prices
                                            .salePrice,
                                        style: AppStyle.styleBold20(context)
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),

                                      SizedBox(width: 8.w),
                                      Text(
                                        product.prices.regularPrice,
                                        style: AppStyle.styleRegular15(context)
                                            .copyWith(
                                              color: AppColors.gray,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                      // SizedBox(width: 8.w),
                                      // Text(
                                      //   '${state.productIdDetailsModel.price.price}',
                                      //   style: AppStyle.styleRegular15(context)
                                      //       .copyWith(
                                      //         color: AppColors.gray,
                                      //         decoration:
                                      //             TextDecoration.lineThrough,
                                      //       ),
                                      // ),
                                    ],
                                  ),

                                  SizedBox(height: 5.h),

                                  Row(
                                    children: [
                                      Text(
                                        product.averageRating,
                                        style: AppStyle.styleRegular14(
                                          context,
                                        ).copyWith(color: Colors.grey.shade600),
                                      ),

                                      SizedBox(width: 5.w),

                                      ...List.generate(5, (index) {
                                        int rating = 0;
                                        try {
                                          rating = double.parse(
                                            product.averageRating,
                                          ).toInt();
                                        } catch (e) {
                                          rating = 0;
                                        }
                                        return Icon(
                                          index < rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 20.r,
                                        );
                                      }),
                                    ],
                                  ),

                                  SizedBox(height: 5.h),

                                  Row(
                                    children: [
                                      Text(
                                        product.reviewCount.toString(),
                                        style: AppStyle.styleRegular14(
                                          context,
                                        ).copyWith(color: AppColors.gray),
                                      ),

                                      SizedBox(width: 5.w),

                                      Icon(
                                        Icons.visibility,
                                        color: AppColors.gray,
                                        size: 15.r,
                                      ),

                                      // SizedBox(width: 10.w),

                                      // Text(
                                      //   '10 منذ ساعات',
                                      //   style: AppStyle.styleRegular10(
                                      //     context,
                                      //   ).copyWith(color: AppColors.gray),
                                      // ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  ProductsSelectionOptions(
                                    attributes: product.attributes,
                                    onSelectionChanged: (attributes, quantity) {
                                      chosenAttributes = attributes;
                                      chosenQuantity = quantity;
                                    },
                                  ),

                                  SizedBox(height: 20.h),

                                  // const CustomExpansionTile(
                                  //   title: "الوصف",
                                  //   content:
                                  //       "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                                  // ),

                                  // SizedBox(height: 20.h),

                                  // const CustomExpansionTile(
                                  //   title: "طريقة الاستعمال",
                                  //   content:
                                  //       "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                                  // ),

                                  // SizedBox(height: 20.h),

                                  // Image.asset(
                                  //   Assets.imagesProductRate,

                                  //   // width: double.infinity,
                                  //   // height: 120.h,
                                  // ),

                                  // SizedBox(height: 30.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: BlocConsumer<AddCartCubit, AddCartState>(
                                      listener: (context, state) {
                                        if (state is AddCartError) {
                                          Fluttertoast.showToast(
                                            gravity: ToastGravity.TOP,
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            msg: state.error.message,
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return product.isInCart!
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  GoRouter.of(
                                                    context,
                                                  ).push(AppRouter.myCart);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.blueC3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16.r,
                                                        ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Go To Cart',
                                                      style:
                                                          AppStyle.styleRegular15(
                                                            context,
                                                          ).copyWith(
                                                            color: Colors.white,
                                                          ),
                                                    ),

                                                    SizedBox(width: 6.w),

                                                    SvgPicture.asset(
                                                      Assets
                                                          .imagesShoppingCartWhite,
                                                      width: 22.w,
                                                      height: 22.h,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : state is AddCartSuccess
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  GoRouter.of(
                                                    context,
                                                  ).push(AppRouter.myCart);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.blueC3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16.r,
                                                        ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Go To Cart',
                                                      style:
                                                          AppStyle.styleRegular15(
                                                            context,
                                                          ).copyWith(
                                                            color: Colors.white,
                                                          ),
                                                    ),

                                                    SizedBox(width: 6.w),

                                                    SvgPicture.asset(
                                                      Assets
                                                          .imagesShoppingCartWhite,
                                                      width: 22.w,
                                                      height: 22.h,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () async {
                                                  final variations =
                                                      chosenAttributes.entries
                                                          .map((entry) {
                                                            return {
                                                              "attribute": entry
                                                                  .key
                                                                  .toLowerCase(),
                                                              "value":
                                                                  entry.value,
                                                            };
                                                          })
                                                          .toList();

                                                  await context
                                                      .read<AddCartCubit>()
                                                      .addToCart(
                                                        productId: product.id
                                                            .toString(),
                                                        variations: variations,
                                                        quantity:
                                                            chosenQuantity,
                                                      );

                                                  if (mounted) {
                                                    context
                                                        .read<GetCartCubit>()
                                                        .getCart();
                                                  }
                                                  MyCartScreen
                                                      .cartKey
                                                      .currentState
                                                      ?.refreshGetCart();
                                                  HomeScreen
                                                      .homeKey
                                                      .currentState
                                                      ?.refreshWishListAndCartList();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16.r,
                                                        ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      state is AddCartLoading
                                                      ? [
                                                          const CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ]
                                                      : [
                                                          Text(
                                                            'Add To Cart',
                                                            style:
                                                                AppStyle.styleRegular15(
                                                                  context,
                                                                ).copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                          SizedBox(width: 6.w),
                                                          SvgPicture.asset(
                                                            Assets
                                                                .imagesShoppingCartWhite,
                                                            width: 18.w,
                                                            height: 18.h,
                                                          ),
                                                        ],
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }

                            if (state is ProductIdDetailsError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      state.error.icon,
                                      color: Colors.red,
                                      size: 50,
                                    ),

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
                                            .read<ProductIdDetailsCubit>()
                                            .getProductDetails(
                                              widget.productId,
                                            );
                                        ();
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
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
