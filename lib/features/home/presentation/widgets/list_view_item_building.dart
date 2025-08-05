import 'package:cached_network_image/cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ListViewItemBuilding extends StatefulWidget {
  const ListViewItemBuilding({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.originalPrice,

 
    required this.onAddToCartTap,
    required this.onAddToWishListTap,
  });

  final String imageUrl;
  final String productName;
  final String originalPrice;
   
  final VoidCallback onAddToCartTap;
  final VoidCallback onAddToWishListTap;

  @override
  State<ListViewItemBuilding> createState() => _ListViewItemBuildingState();
}

class _ListViewItemBuildingState extends State<ListViewItemBuilding> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => Skeletonizer(
                  enabled: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(Assets.imagesShoes, fit: BoxFit.cover),
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
                  InkWell(
                    onTap: widget.onAddToWishListTap,
                    child: Image.asset(Assets.imagesSave, width: 25.w, height: 25.h)),
                ],
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  Text(
                    '${1500}',
                    style: AppStyle.styleBold20(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.originalPrice,
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
                    '${4.5}',
                    style: AppStyle.styleRegular14(
                      context,
                    ).copyWith(color: Colors.grey.shade600),
                  ),

                  SizedBox(width: 5.w),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < 4.5.floor() ? Icons.star : Icons.star_border,
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
                    '32 مشاهده',
                    style: AppStyle.styleRegular10(
                      context,
                    ).copyWith(color: AppColors.gray),
                  ),

                  SizedBox(width: 10.w),

                  Text(
                    '10 منذ ساعات',
                    style: AppStyle.styleRegular10(
                      context,
                    ).copyWith(color: AppColors.gray),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onAddToCartTap,
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
                        'أضف للعربة',
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),

                      SizedBox(width: 6.w),

                      SvgPicture.asset(
                        Assets.imagesShoppingCartWhite,
                        width: 22.w,
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
