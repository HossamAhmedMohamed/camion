import 'package:camion/config/widgets/custom_list_tile.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationLoadingSkeletonizer extends StatelessWidget {
  const NotificationLoadingSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
  
        return Column(
          children: [
            CustomListTile(
              leading: Image.asset(
                Assets.imagesCamionLogo,
                width: 30.w,
                height: 30.h,
              ),
              trailing: Icon(
                Icons.check,
                color: AppColors.primaryColor,
                size: 34.sp,
              ),
              title: "تم استلام طلبك",
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "طلبك قيد التنفيذ",
                    style: AppStyle.styleRegular14(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  Text(
                    "11 ساعة",
                    style: AppStyle.styleRegular12(
                      context,
                    ).copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Divider(color: AppColors.paleGray),
                  ),
                ),
              ],
            ),
          ],
        );
  }
}
