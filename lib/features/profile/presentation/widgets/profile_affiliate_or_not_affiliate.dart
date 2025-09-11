import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileNotaffiliateShown extends StatelessWidget {
  const ProfileNotaffiliateShown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.imagesPlay),

        SizedBox(width: 10.w),

        Expanded(
          child: Text(
             S.of(context).You_are_not_subscribed_to_affiliate_marketing,
            style: AppStyle.styleRegular14(context).copyWith(color: Colors.black),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: AppColors.primaryColor,
          ),

          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.affiliateCheckScreen);
            },
            child: Text(
              
              S.of(context).subscribe_now,
              style: AppStyle.styleRegular14(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileAffiliateShown extends StatelessWidget {
  const ProfileAffiliateShown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.imagesPlay),

        SizedBox(width: 10.w),

        Expanded(
          child: Text(
             S.of(context).You_are_subscribed_to_affiliate_marketing,
            style: AppStyle.styleRegular14(context).copyWith(color: Colors.black),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: const Color(0xFF03B603),
          ),

          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.supplierAccount);
            },
            child: Text(
               S.of(context).view_your_activity,
              style: AppStyle.styleRegular14(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
