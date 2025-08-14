import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponsListViewSkeletonizer extends StatelessWidget {
  const CouponsListViewSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mariam12",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black),
              ),

              Text(
                "5%",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.gray),
              ),
            ],
          ),

          const Row(
            children: [
              Expanded(
                child: Divider(color: AppColors.lightGray, thickness: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
