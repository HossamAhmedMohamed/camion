import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key, required this.screenWidth});

  final double screenWidth;
  VoidCallback onCategoreyTap(BuildContext context, {required String title}) {
    return () {
      GoRouter.of(context).push(
        AppRouter.category,
        extra: {
          "title": Text(
            title,
            style: AppStyle.styleRegular18(
              context,
            ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
          ),
          "leading": GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: Icon(Icons.arrow_back, color: AppColors.black, size: 25.sp),
          ),
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    List<CategoriesModel> firstCategories = [
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "الاطفال"),
        title: "الاطفال",
        image: Assets.imagesChildren,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "الاثاث"),
        title: "الأثاث",
        image: Assets.imagesFurniture,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "الموضة"),
        title: "الموضة",
        image: Assets.imagesClothes,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "المطبخ"),
        title: "المطبخ",
        image: Assets.imagesKithcen,
      ),
    ];

    List<CategoriesModel> secondCategories = [
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "البيت"),
        title: "البيت",
        image: Assets.imagesHomeCategory,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "الاجهزة"),
        title: "الاجهزة",
        image: Assets.imagesDevices,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "المطبخ"),
        title: "المطبخ",
        image: Assets.imagesKithcen,
      ),
      CategoriesModel(
        onTap: onCategoreyTap(context, title: "الموبايل"),
        title: "الموبايل",
        image: Assets.imagesMobile,
      ),
    ];

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
                return GestureDetector(
                  onTap: firstCategories[index].onTap,
                  child: Container(
                    height: screenWidth > 800 ? 120.h : 80.h,
                    width: screenWidth > 800 ? 120.w : 80.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(firstCategories[index].image!),

                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        firstCategories[index].title,
                        style: AppStyle.styleRegular14(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 15.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: secondCategories[index].onTap,
                  child: Container(
                    height: screenWidth > 800 ? 120.h : 80.h,
                    width: screenWidth > 800 ? 120.w : 80.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(secondCategories[index].image!),

                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          secondCategories[index].title,
                          style: AppStyle.styleRegular14(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
