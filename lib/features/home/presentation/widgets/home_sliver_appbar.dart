import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key, this.isShownDivider});

  final bool? isShownDivider;
  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      title: Image.asset(Assets.imagesCamionLogo, width: 65.w, height: 50.h),
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
      isShownDivider: isShownDivider,
    );
  }
}
