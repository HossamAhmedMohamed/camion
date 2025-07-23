import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectingAddress extends StatelessWidget {
  const CustomSelectingAddress({
    super.key,
    required this.title,
    required this.isSelected, required this.onTap,
  });

  final VoidCallback onTap;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(
              color: isSelected ? AppColors.primaryColor : AppColors.metal,
              width: 1.5,
            ),
          ),
      
          color: isSelected ? AppColors.primaryColor.withAlpha(15) : Colors.white,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: AppStyle.styleBold16(
              context,
            ).copyWith(color: isSelected ? AppColors.primaryColor : AppColors.gray),
          ),
        ),
      ),
    );
  }
}
