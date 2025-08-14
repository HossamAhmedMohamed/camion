 
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RejectedScreen extends StatelessWidget {
  const RejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(width: 230.w, height: 250.h, Assets.imagesJoinUsPhoto),

        SizedBox(height: 10.h),

        Text(
          'Rejected',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8.h),

        Text(
          'Your registration request has been rejected.\nPlease try registering again.',
          style: TextStyle(fontSize: 16.sp, color: Colors.black54),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 30.h),

        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.joinUs);  
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Register Again As Affiliate',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
