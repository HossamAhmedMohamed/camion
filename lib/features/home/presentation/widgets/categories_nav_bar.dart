import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesNavBar extends StatelessWidget {
  const CategoriesNavBar({
    super.key,
    required this.isActive, required this.title,  
  });

  final bool isActive;
  final String title;
   

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        // vertical: 8.h,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: isActive
                ? AppColors.primaryColor
                : AppColors.gray,
            width: isActive ? 1.5.w : 1.w,
          ),
        ),
                
        color: isActive
            ? AppColors.primaryColor.withAlpha(25)
            : Colors.white,
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            title,
            style: AppStyle.styleRegular15(context).copyWith(
              color: isActive
                  ? AppColors.primaryColor
                  : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
