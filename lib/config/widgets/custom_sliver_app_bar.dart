
import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.title, this.leading});

  final Widget title;
  final Widget? leading;
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
      leading: leading,

      title: title,
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
