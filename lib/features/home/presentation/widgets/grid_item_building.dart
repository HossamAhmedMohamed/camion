import 'package:cached_network_image/cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GridItemBuilding extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String originalPrice;
  final String averageRating;
  final String reviewCount;
  final String outPrice;
  final String productId;
  final VoidCallback onTap;
  final String currencyCode;
  const GridItemBuilding({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,
    required this.onTap,
    required this.averageRating,
    required this.reviewCount,
    required this.outPrice,
    required this.productId,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image and discount badge
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
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
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(Assets.imagesShoes, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ],
            ),
          ),
        ),

        // Product details
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.styleBold14(
                    context,
                  ).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  textDirection: TextDirection.ltr,
                ),

                SizedBox(height: 6.h),

                // Price information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              originalPrice,
                              style: AppStyle.styleBold16(
                                context,
                              ).copyWith(color: AppColors.primaryColor),
                            ),

                            SizedBox(width: 5.w),
                            Text(
                              currencyCode,
                              style: AppStyle.styleBold16(
                                context,
                              ).copyWith(color: AppColors.primaryColor),
                            ),
                            // SizedBox(width: 5.w),
                            // Text(
                            //   "$outPrice $currencyCode",
                            //   style: AppStyle.styleRegular12(context).copyWith(
                            //     color: AppColors.gray,
                            //     decoration: TextDecoration.lineThrough,
                            //   ),
                            // ),
                          ],
                        ),

                        SizedBox(height: 6.h),

                        Row(
                          children: [
                            Text(
                              averageRating,
                              style: AppStyle.styleRegular12(
                                context,
                              ).copyWith(color: Colors.black),
                            ),
                            SizedBox(width: 2.w),
                            Icon(Icons.star, color: Colors.amber, size: 14.sp),

                            SizedBox(width: 4.w),
                            // Text(
                            //   "( 50  تقييم )",
                            //   style: AppStyle.styleRegular12(
                            //     context,
                            //   ).copyWith(color: const Color(0xFFF9B023)),
                            // ),

                            // ...List.generate(
                            //   5,
                            //   (index) => Icon(
                            //     index < 4.5.floor() ? Icons.star : Icons.star_border,
                            //     color: Colors.amber,
                            //     size: 14.r,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.productDetails, extra: productId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 6.h,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          color: AppColors.primaryColor,
                        ),

                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ),

                    // : GestureDetector(
                    //     onTap: () {},
                    //     child: Container(
                    //       padding: EdgeInsets.all(10.r),
                    //       decoration: const ShapeDecoration(
                    //         shape: CircleBorder(),
                    //         color: AppColors.primaryColor,
                    //       ),

                    //       child: Text(
                    //         "1",
                    //         style: AppStyle.styleRegular14(
                    //           context,
                    //         ).copyWith(color: Colors.white),
                    //       ),
                    //     ),
                    //   );
                  ],
                ),

                // Row(
                //   children: [
                //     Image.asset(
                //       Assets.imagesBagCheck,
                //       width: 20.w,
                //       height: 20.h,
                //     ),
                //     SizedBox(width: 5.h),
                //     Text(
                //       '$sellCount منتجًا مباعًا',
                //       style: AppStyle.styleRegular14(
                //         context,
                //       ).copyWith(color: AppColors.gray),
                //     ),
                //   ],
                // ),

                // SizedBox(height: 4.h),

                // SizedBox(height: 5.h),

                // Row(
                //   children: [
                //     Icon(Icons.visibility, color: AppColors.gray, size: 15.r),
                //     SizedBox(width: 5.w),
                //     Text(
                //       '32 مشاهده',
                //       style: AppStyle.styleRegular10(
                //         context,
                //       ).copyWith(color: AppColors.gray),
                //     ),

                //     SizedBox(width: 10.w),

                //     Text(
                //       '10 منذ ساعات',
                //       style: AppStyle.styleRegular10(
                //         context,
                //       ).copyWith(color: AppColors.gray),
                //     ),
                //   ],
                // ),
                // const Spacer(),

                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       padding: EdgeInsets.symmetric(vertical: 8.h),
                //       backgroundColor: AppColors.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.r),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'أضف للعربة',
                //           style: AppStyle.styleRegular15(
                //             context,
                //           ).copyWith(color: Colors.white),
                //         ),
                //         SizedBox(width: 8.w),
                //         SvgPicture.asset(
                //           Assets.imagesShoppingCartWhite,
                //           width: 18.w,
                //           height: 18.h,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
