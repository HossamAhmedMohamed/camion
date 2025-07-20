import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GridItemBuilding extends StatefulWidget {
  final List<String> productImages;
  final String discountImage;
  final String productName;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final int reviewCount;
  final int sellCount;

  const GridItemBuilding({
    super.key,
    required this.productImages,
    required this.discountImage,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.sellCount,
  });

  @override
  State<GridItemBuilding> createState() => _GridItemBuildingState();
}

class _GridItemBuildingState extends State<GridItemBuilding> {
  int currentIndex = 0;
  late PageController _imagePageController;

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image and discount badge
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Stack(
            children: [
              // PageView للصور
              PageView.builder(
                controller: _imagePageController,
                itemCount: widget.productImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Center(
                      child: Image.asset(
                        widget.productImages[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),

              // Discount badge
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Image.asset(
                  widget.discountImage,
                  width: 40.w,
                  height: 40.h,
                ),
              ),

              // Save button
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      red: 255,
                      green: 255,
                      blue: 255,
                      alpha: 204,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Assets.imagesSave,
                    width: 18.w,
                    height: 18.h,
                  ),
                ),
              ),

              // Page indicators
              if (widget.productImages.length > 1)
                Positioned(
                  bottom: 16.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.productImages.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _imagePageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: currentIndex == index ? 20.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? const Color(0xFFD32F2F)
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // Sold count badge
              // Positioned(
              //   left: 8.w,
              //   bottom: 16.h,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 6.w,
              //       vertical: 3.h,
              //     ),
              //     decoration: ShapeDecoration(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20.r),
              //       ),
              //       color: const Color(0xFFF0F0F0),
              //     ),
              //     child: Row(
              //       children: [
              //         Image.asset(
              //           Assets.imagesBagCheck,
              //           width: 14.w,
              //           height: 14.h,
              //         ),
              //         SizedBox(width: 3.w),
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

        // Product details
        Expanded(
          // استخدام Expanded لملء المساحة المتبقية
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  widget.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.styleBold14(context),
                ),

                SizedBox(height: 4.h),

                // Price information
                Row(
                  children: [
                    Text(
                      '${widget.discountedPrice.toInt()}',
                      style: AppStyle.styleBold16(
                        context,
                      ).copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '${widget.originalPrice.toInt()}',
                      style: AppStyle.styleRegular12(context).copyWith(
                        color: AppColors.gray,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                Row(
                  children: [
                    Image.asset(
                      Assets.imagesBagCheck,
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      '${widget.sellCount} منتجًا مباعًا',
                      style: AppStyle.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.gray),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                Row(
                  children: [
                    Text(
                      '${widget.rating}',
                      style: AppStyle.styleRegular12(
                        context,
                      ).copyWith(color: Colors.grey.shade600),
                    ),
                    SizedBox(width: 2.w),
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < widget.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 14.r,
                      ),
                    ),
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

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
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
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          Assets.imagesShoppingCartWhite,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
