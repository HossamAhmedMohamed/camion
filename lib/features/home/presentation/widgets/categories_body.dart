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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الاقسام",
                  style: AppStyle.styleSemiBold16(context).copyWith(
                    color: AppColors.black,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    final extra = firstCategories + secondCategories;
                    GoRouter.of(
                      context,
                    ).push(AppRouter.allCategoriesScreen, extra: extra);
                  },

                  child: Text(
                    "عرض الكل",
                    style: AppStyle.styleRegular14(context).copyWith(
                      color: AppColors.primaryColor,

                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          AspectRatio(
            aspectRatio: screenWidth >= 800 ? 350.w / 140.h : 350.w / 180.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(firstCategories.length, (
                          index,
                        ) {
                          return GestureDetector(
                            onTap: firstCategories[index].onTap,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 15.w,
                                right: index == 0 ? 15.w : 0,
                              ),
                              height: screenWidth > 800 ? 120.h : 80.h,
                              width: screenWidth > 800 ? 120.w : 80.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    firstCategories[index].image!,
                                  ),

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(secondCategories.length, (
                          index,
                        ) {
                          return GestureDetector(
                            onTap: secondCategories[index].onTap,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 15.w,
                                right: index == 0 ? 15.w : 0,
                              ),
                              height: screenWidth > 800 ? 120.h : 80.h,
                              width: screenWidth > 800 ? 120.w : 80.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    secondCategories[index].image!,
                                  ),

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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
