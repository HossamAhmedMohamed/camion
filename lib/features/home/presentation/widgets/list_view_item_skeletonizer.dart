import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListViewItemBuildingSkeleton extends StatelessWidget {
  const ListViewItemBuildingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة المنتج
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              // صورة ثابتة مؤقتة من الأصول
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  Assets.imagesShoes,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // discount badge
              Positioned(
                top: 16.h,
                left: 16.w,
                child: Image.asset(
                  Assets.imagesDiscount,
                  width: 60,
                  height: 60,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // باقي التفاصيل
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              // اسم المنتج و الأيقونة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'اسم المنتج هنا',
                      style: AppStyle.styleBold18(context),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Image.asset(
                    Assets.imagesSave,
                    width: 25.w,
                    height: 25.h,
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // السعر
              Row(
                children: [
                  Text(
                    '1500',
                    style: AppStyle.styleBold20(context)
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '2000',
                    style: AppStyle.styleRegular15(context).copyWith(
                      color: AppColors.gray,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h),

              // التقييم
              Row(
                children: [
                  Text(
                    '4.5',
                    style: AppStyle.styleRegular14(context)
                        .copyWith(color: Colors.grey.shade600),
                  ),
                  SizedBox(width: 5.w),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20.r,
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

              const SizedBox(height: 20),

              // زر أضف للعربة
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
                        style: AppStyle.styleRegular15(context)
                            .copyWith(color: Colors.white),
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
