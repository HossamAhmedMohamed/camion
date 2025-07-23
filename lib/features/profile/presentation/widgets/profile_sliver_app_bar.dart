import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSliverAppBar extends StatelessWidget {
  const ProfileSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      title: Image.asset(Assets.imagesCamionLogo, width: 65.w, height: 50.h),
      leadingWidth: 50.w,
      leading: Container(
        // margin: EdgeInsets.only(right: 2.w),
        padding: EdgeInsets.all(13.r),
        child: GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(Assets.imagesProfileSettings),
        ),
      ),

      isShownDivider: true,
    );
  }
}
