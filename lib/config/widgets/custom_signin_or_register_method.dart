import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSelectingMethods extends StatelessWidget {
  const CustomSelectingMethods({
    super.key,
    required this.onTap,
    required this.registerLogo,
    required this.text,
  });

  final VoidCallback onTap;
  final String registerLogo;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: AppColors.metal, width: 1.w),
          ),
          color: Colors.white,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(registerLogo, width: 24.w, height: 24.h),

            SizedBox(width: 12.w),
            Text(
              text,
              style: AppStyle.styleRegular14(
                context,
              ).copyWith(color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
