import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GridItemBuildingSkeleton extends StatelessWidget {
  const GridItemBuildingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة المنتج + discount badge + save icon
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  Assets.imagesShoes,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Image.asset(
                  Assets.imagesDiscount,
                  width: 40.w,
                  height: 40.h,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Assets.imagesSave,
                    width: 18.w,
                    height: 18.h,
                  ),
                ),
              ),
            ],
          ),
        ),

        // التفاصيل
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم المنتج
                Text(
                  'اسم المنتج التجريبي',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.styleBold14(context),
                  textDirection: TextDirection.ltr,
                ),

                SizedBox(height: 4.h),

                // السعر
                Row(
                  children: [
                    Text(
                      '1500',
                      style: AppStyle.styleBold16(context)
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '2000',
                      style: AppStyle.styleRegular12(context).copyWith(
                        color: AppColors.gray,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // عدد المنتجات المباعة
                Row(
                  children: [
                    Image.asset(
                      Assets.imagesBagCheck,
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '25 منتجًا مباعًا',
                      style: AppStyle.styleRegular14(context)
                          .copyWith(color: AppColors.gray),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // التقييم
                Row(
                  children: [
                    Text(
                      '4.5',
                      style: AppStyle.styleRegular12(context)
                          .copyWith(color: Colors.grey.shade600),
                    ),
                    SizedBox(width: 2.w),
                    ...List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 14.r,
                      );
                    }),
                  ],
                ),

                SizedBox(height: 5.h),

                // المشاهدات و الوقت
                Row(
                  children: [
                    Icon(Icons.visibility, color: AppColors.gray, size: 15.r),
                    SizedBox(width: 5.w),
                    Text(
                      '32 مشاهده',
                      style: AppStyle.styleRegular10(context)
                          .copyWith(color: AppColors.gray),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'منذ 10 ساعات',
                      style: AppStyle.styleRegular10(context)
                          .copyWith(color: AppColors.gray),
                    ),
                  ],
                ),

                const Spacer(),

                // زر أضف للعربة
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
                          style: AppStyle.styleRegular15(context)
                              .copyWith(color: Colors.white),
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
