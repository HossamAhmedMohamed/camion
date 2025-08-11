import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeJoinUsNow extends StatelessWidget {
  const HomeJoinUsNow({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 374.h / 180.w,
        child: Container(
          // height: screenWidth > 800 ? 260.h : 180.h,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.imagesIconsNewJoinUs),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.supplierWelcome);
                },
                child: Container(
                  // height: 32.h,
                  width: screenWidth > 800 ? 170.w : 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.primaryColor,
                  ),
        
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: FittedBox(
                      // fit: BoxFit.scaleDown,
                      child: Text(
                        "انضم الينا الان",
                        style: AppStyle.styleRegular14(
                          context,
                        ).copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
