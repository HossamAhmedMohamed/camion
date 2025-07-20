import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70.0.h,
      floating: true,
      snap: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      actionsPadding: EdgeInsets.only(left: 12.w),

      leadingWidth: 70.w,
      leading: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(2.r),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
            side: BorderSide(color: AppColors.grayB4, width: 1.w),
          ),
         
        ),
        child: Image.asset(
          Assets.imagesWoman,
          width: 65.w,
          height: 65.h,
          fit: BoxFit.cover,
        ),
      ),

      title: Image.asset(Assets.imagesCamionLogo, width: 65.w, height: 50.h),
      centerTitle: true,

      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.imagesShoppingCart,
              width: 30.w,
              height: 30.h,
            ),

            SizedBox(width: 16.w),

            SvgPicture.asset(
              Assets.imagesNotification,
              width: 30.w,
              height: 30.h,
            ),
          ],
        ),
      ],
    );
  }
}
