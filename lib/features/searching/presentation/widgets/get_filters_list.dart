import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

List<CategoriesModel> getFilters(BuildContext context) {
    List<CategoriesModel> categories = [
      CategoriesModel(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.category,
            extra: {
              "title": Text(
                "الاطفال",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              "leading": GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),
            },
          );
        },
        title: "الاطفال",
      ),
      CategoriesModel(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.category,
            extra: {
              "title": Text(
                "الاثاث",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              "leading": GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),
            },
          );
        },
        title: "الاثاث",
      ),
      CategoriesModel(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.category,
            extra: {
              "title": Text(
                "الموضة",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              "leading": GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),
            },
          );
        },
        title: "الموضة",
      ),
      CategoriesModel(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.category,
            extra: {
              "title": Text(
                "المطبخ",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              "leading": GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),
            },
          );
        },
        title: "المطبخ",
      ),
    ];
    return categories;
  }