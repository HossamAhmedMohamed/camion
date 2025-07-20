import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  static const List<String> firstCategories = [
    Assets.imagesChildren,
    Assets.imagesFurniture,
    Assets.imagesModaaa,
    Assets.imagesKitchen,
  ];

  static const List<String> secondCategories = [
    Assets.imagesHomeCategory,
    Assets.imagesDevices,
    Assets.imagesKitchen,
    Assets.imagesMobile,
  ];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الاقسام",
                  style: AppStyle.styleSemiBold18(
                    context,
                  ).copyWith(color: AppColors.black),
                ),

                GestureDetector(
                  onTap: () {},

                  child: Text(
                    "المزيد",
                    style: AppStyle.styleRegular14(context).copyWith(
                      color: AppColors.primaryColor,

                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Image.asset(
                  firstCategories[index],
                  width: 80.w,
                  height: 80.h,
                );
              }),
            ),

            SizedBox(
              height: 15.h,
            ),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Image.asset(
                  secondCategories[index],
                  width: 80.w,
                  height: 80.h,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
