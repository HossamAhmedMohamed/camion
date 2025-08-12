import 'package:cached_network_image/cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewItemBuilding extends StatefulWidget {
  const ListViewItemBuilding({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,
    required this.productId,
    required this.onAddToCartTap,
    required this.onAddToWishListTap,
    required this.outPrice,
    required this.averageRating,
    required this.reviewCount,
  });

  final String imageUrl;
  final String productName;
  final String originalPrice;
  final String outPrice;
  final String productId;
  final VoidCallback onAddToCartTap;
  final VoidCallback onAddToWishListTap;
  final String averageRating;
  final String reviewCount;

  @override
  State<ListViewItemBuilding> createState() => _ListViewItemBuildingState();
}

class _ListViewItemBuildingState extends State<ListViewItemBuilding> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenWidth > 800 ? 500.h : 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Skeletonizer(
                  enabled: true,
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(Assets.imagesShoes, fit: BoxFit.fill),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // PageView.builder(
              //   controller: widget.pageController,
              //   onPageChanged: (index) {
              //     setState(() {
              //        currentIndex = index;
              //     });
              //   },
              //   itemCount: widget.productImages.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: EdgeInsets.all(20.0.r),
              //       child: Image.asset(
              //         widget.productImages[index],
              //         height: 215.h,
              //         fit: BoxFit.contain,
              //       ),
              //     );
              //   },
              // ),
              // Positioned(
              //   top: 16.h,
              //   left: 16.w,
              //   child: Image.asset(
              //     Assets.imagesDiscount,
              //     width: 60,
              //     height: 60,
              //   ),
              // ),

              // Positioned(
              //   bottom: 16.h,
              //   left: 0,
              //   right: 0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: List.generate(
              //       widget.productImages.length,
              //       (index) => Container(
              //         margin: EdgeInsets.symmetric(horizontal: 4.w),
              //         width: currentIndex == index ? 20.w : 8.w,
              //         height: 8.h,
              //         decoration: BoxDecoration(
              //           color: currentIndex == index
              //               ? const Color(0xFFD32F2F)
              //               : Colors.grey.shade400,
              //           borderRadius: BorderRadius.circular(4.r),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 16.w,
              //   bottom: 16.h,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              //     decoration: ShapeDecoration(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30.r),
              //       ),
              //       color: const Color(0xFFF0F0F0),
              //     ),
              //     child: Row(
              //       children: [
              //         Image.asset(
              //           Assets.imagesBagCheck,
              //           width: 20.w,
              //           height: 20.h,
              //         ),
              //         SizedBox(width: 5.h),
              //         Text(
              //           '${widget.sellCount} منتجًا مباعًا',
              //           style: AppStyle.styleRegular14(
              //             context,
              //           ).copyWith(color: AppColors.gray),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.productName,
                      style: AppStyle.styleBold18(context),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  BlocBuilder<GetWishListCubit, GetWishListState>(
                    builder: (context, state) {
                      bool isInWishList = false;

                      if (state is GetWishListSuccess) {
                        if (state.wishLists.isEmpty) {
                          isInWishList = false;
                        } else {
                          isInWishList = state.wishLists.any(
                            (item) => item.productId == widget.productId,
                          );
                        }
                      }

                      return InkWell(
                        onTap: () {
                          if (isInWishList) {
                            context.read<GetWishListCubit>().removeFromWishList(
                              productId: widget.productId,
                            );
                          } else {
                            widget.onAddToWishListTap();
                          }
                        },
                        child: SvgPicture.asset(
                          isInWishList
                              ? Assets.imagesIconsNewwwwwActiveFavourites
                              : Assets
                                    .imagesIconsInactiveFavouriteIconNewNavbar,
                          width: 25.w,
                          height: 25.h,
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  Text(
                    widget.originalPrice,
                    style: AppStyle.styleBold20(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.outPrice,
                    style: AppStyle.styleRegular15(context).copyWith(
                      color: AppColors.gray,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              Row(
                children: [
                  Text(
                    widget.averageRating,
                    style: AppStyle.styleRegular14(
                      context,
                    ).copyWith(color: Colors.grey.shade600),
                  ),

                  SizedBox(width: 5.w),
                  ...List.generate(5, (index) {
                    int rating = 0;
                    try {
                      rating = double.parse(widget.averageRating).toInt();
                    } catch (e) {
                      rating = 0;
                    }
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20.r,
                    );
                  }),
                ],
              ),

              SizedBox(height: 5.h),

              Row(
                children: [
                  Icon(Icons.visibility, color: AppColors.gray, size: 15.r),
                  SizedBox(width: 5.w),
                  Text(
                    widget.reviewCount,
                    style: AppStyle.styleRegular10(
                      context,
                    ).copyWith(color: AppColors.gray),
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

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.productDetails ,
                    extra: widget.productId
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اختر منتج',
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),

                      // SizedBox(width: 6.w),

                      // SvgPicture.asset(
                      //   Assets.imagesShoppingCartWhite,
                      //   width: 22.w,
                      //   height: 22.h,
                      // ),
                    ],
                  ),
                ),
                // child: BlocBuilder<AddCartCubit, AddCartState>(
                //   builder: (context, state) {
                //     final cubit = context.read<AddCartCubit>();
                //     final isInCart = cubit.isProductInCart(widget.productId);
                //     final isLoading =
                //         state is AddCartLoading &&
                //         state.productId == widget.productId;
                //     return isInCart
                //         ? ElevatedButton(
                //             onPressed: () {
                //               GoRouter.of(context).push(AppRouter.myCart);
                //             },
                //             style: ElevatedButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 16.h),
                //               backgroundColor: AppColors.blueC3,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(16.r),
                //               ),
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: isLoading
                //                   ? [
                //                       const CircularProgressIndicator(
                //                         color: Colors.white,
                //                       ),
                //                     ]
                //                   : [
                //                       Text(
                //                         'أذهب الي العربة',
                //                         style: AppStyle.styleRegular15(
                //                           context,
                //                         ).copyWith(color: Colors.white),
                //                       ),

                //                       SizedBox(width: 6.w),

                //                       SvgPicture.asset(
                //                         Assets.imagesShoppingCartWhite,
                //                         width: 22.w,
                //                         height: 22.h,
                //                       ),
                //                     ],
                //             ),
                //           )
                //         : ElevatedButton(
                //             onPressed: state is! AddCartLoading
                //                 ? () {}
                //                 : widget.onAddToCartTap,
                //             style: ElevatedButton.styleFrom(
                //               padding: EdgeInsets.symmetric(vertical: 16.h),
                //               backgroundColor: AppColors.primaryColor,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(16.r),
                //               ),
                //             ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: state is AddCartLoading
                //                   ? [
                //                       const CircularProgressIndicator(
                //                         color: Colors.white,
                //                       ),
                //                     ]
                //                   : [
                //                       Text(
                //                         'أضف للعربة',
                //                         style: AppStyle.styleRegular15(
                //                           context,
                //                         ).copyWith(color: Colors.white),
                //                       ),

                //                       SizedBox(width: 6.w),

                //                       SvgPicture.asset(
                //                         Assets.imagesShoppingCartWhite,
                //                         width: 22.w,
                //                         height: 22.h,
                //                       ),
                //                     ],
                //             ),
                //           );
                //   },
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
