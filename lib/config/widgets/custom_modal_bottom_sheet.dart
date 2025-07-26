
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> customizeModalBottomSheet({
  required String title,
  required Widget content,
  required double screenWidth,
  required BuildContext context,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxWidth: screenWidth),
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Icon(Icons.close, color: AppColors.black, size: 30.sp),
                ),

                SizedBox(height: 20.h),

                Center(
                  child: Image.asset(
                    Assets.imagesCheck,
                    width: screenWidth > 800 ? 160.w : 120.w,
                    height: screenWidth > 800 ? 160.h : 120.h,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 35.h),

                Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: AppStyle.styleSemiBold16(
                        context,
                      ).copyWith(color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: 35.h),

                content ,
              ],
            ),
          ),
        ],
      );
    },
  );
}
