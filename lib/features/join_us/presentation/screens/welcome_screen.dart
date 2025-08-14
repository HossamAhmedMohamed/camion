import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const CustomJoinUsSliverAppBar(title: "Affiliate Marketing"),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    width: 230.w,
                    height: 250.h,
                    Assets.imagesJoinUsPhoto,
                  ),

                  SizedBox(height: 40.h),
                  Text(
                    textAlign: TextAlign.center,
                    "We are honored to have you join our marketing team",
                    style: AppStyle.styleRegular18(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 26.h),

                  Text(
                    textAlign: TextAlign.center,
                    "We offer a simple and effective affiliate marketing system based on unique codes for each marketer. These codes can be shared with their audience, allowing them to earn a commission on every sale made using the code. The commission is transferred directly to their wallet without any intermediaries or delays, ensuring fast and easy payouts.We provide a wide variety of products across different fields, so every marketer can find what suits their audience and achieve the highest sales rates. Our goal is to help you earn a steady income through minimal effort and smart marketing",
                    style: AppStyle.styleRegular14(context).copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  CustomElevatedButton(
                    child: Text(
                      "Start Now",
                      style: AppStyle.styleRegular15(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.joinUs);
                    },
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
