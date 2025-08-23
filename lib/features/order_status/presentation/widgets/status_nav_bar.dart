import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StatusNavBar extends StatelessWidget {
  const StatusNavBar({
    super.key,
    required this.isActive,
    required this.title,
    this.image,
  });

  final bool isActive;
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: !isActive ? 10.w : 20.w,
        vertical: 13.h,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),

        color: isActive ? AppColors.primaryColor : Colors.transparent,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null ? Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: SvgPicture.asset(image!),
            ) : Container(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: AppStyle.styleRegular15(
                  context,
                ).copyWith(color: isActive ? AppColors.white : AppColors.black3939),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
