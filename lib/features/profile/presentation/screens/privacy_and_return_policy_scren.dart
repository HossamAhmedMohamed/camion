import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrivacyAndReturnPolicyScren extends StatelessWidget {
  const PrivacyAndReturnPolicyScren({super.key});

  Widget buildPolicySection(
    BuildContext context,
    String title,
    List<String> points,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.styleBold20(
              context,
            ).copyWith(color: AppColors.black),
          ),
          SizedBox(height: 10.h),
          ...points.map(
            (point) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                "• $point",
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              S.of(context).privacy_policy,
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 24.sp,
              ),
            ),
            actions: const [],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).privacy_poilicy_camion_app,
                    style: AppStyle.styleBold20(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  SizedBox(height: 20.h),

                  // Terms of Use
                  buildPolicySection(context, S.of(context).terms_of_use, [
                    S.of(context).terms_of_use_description1,
                    S.of(context).terms_of_use_description2,
                    S.of(context).terms_of_use_description3,
                  ]),

                  // Product Policy
                  buildPolicySection(context, S.of(context).product_policy, [
                    S.of(context).product_policy_description1,
                    S.of(context).product_policy_description2,
                    S.of(context).product_policy_description3,
                  ]),

                  // Payment Policy
                  buildPolicySection(context, S.of(context).payment_policy, [
                    S.of(context).payment_policy_description1,
                    S.of(context).payment_policy_description2,
                    S.of(context).payment_policy_description3,
                  ]),

                  // Shipping & Delivery Policy
                  buildPolicySection(context, S.of(context).shipping_policy, [
                    S.of(context).shipping_policy_description1,
                    S.of(context).shipping_policy_description2,
                    S.of(context).shipping_policy_description3,
                    S.of(context).shipping_policy_description4,
                  ]),

                  // Return & Refund Policy
                  buildPolicySection(context, S.of(context).return_policy, [
                    S.of(context).return_policy_description1,
                    S.of(context).return_policy_description2,
                    S.of(context).return_policy_description3,
                    S.of(context).return_policy_description4,
                  ]),

                  // Privacy Policy
                  buildPolicySection(
                    context,
                    S.of(context).privacy_policy_details,
                    [
                      S.of(context).privacy_policy_description1,
                      S.of(context).privacy_policy_description2,
                      S.of(context).privacy_policy_description3,
                      S.of(context).privacy_policy_description4,
                    ],
                  ),

                  // Limitation of Liability
                  buildPolicySection(
                    context,
                    S.of(context).limitation_liability,
                    [
                      S.of(context).limitation_liability_description1,
                      S.of(context).limitation_liability_description2,
                      S.of(context).limitation_liability_description3,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
