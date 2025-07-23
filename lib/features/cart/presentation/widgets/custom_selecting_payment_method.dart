import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectingCartDetailsMethod extends StatelessWidget {
  const CustomSelectingCartDetailsMethod({
    super.key,
    required this.onTap,
    required this.registerLogo,
    required this.text,
    required this.isSelected,
  });

  final VoidCallback onTap;
  final String registerLogo;
  final String text;
  final bool isSelected;
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
            side: BorderSide(
              color: isSelected ? AppColors.primaryColor : AppColors.metal,
              width: 1.w,
            ),
          ),
          color: isSelected
              ? AppColors.primaryColor.withAlpha(15)
              : Colors.white,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              registerLogo,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),

            SizedBox(width: 6.w),
            Text(
              text,
              style: AppStyle.styleBold14(
                context,
              ).copyWith(color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
