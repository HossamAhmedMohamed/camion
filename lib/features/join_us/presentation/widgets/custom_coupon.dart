import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCoupon extends StatelessWidget {
  const CustomCoupon({
    super.key,
    required this.couponCode,
    required this.discountPercentage,
  });

  final String couponCode;
  final String discountPercentage;
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
                couponCode,
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(
                    fontWeight: FontWeight.w700,
                  color: AppColors.black),
              ),

              Text(
                "$discountPercentage%",
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
