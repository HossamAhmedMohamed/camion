import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

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
               S.of(context).feedback,
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

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
          ),

          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesIconsFeedbackImageLogo,
                  width: 135.w,
                  height: 154.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 15.h),
                Text(
                  textAlign: TextAlign.center,
                   S.of(context).help_us_improve,
                  style: AppStyle.styleBold20(
                    context,
                  ).copyWith(color: AppColors.primaryColor),
                ),

                SizedBox(height: 10.h),
                Text(
                   S.of(context).feed_back_description,
                  style: AppStyle.styleRegular16(
                    context,
                  ).copyWith(color: const Color(0xFF484C52)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'info@camion-app.com',
                      );

                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(
                          emailUri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          gravity: ToastGravity.TOP,
                          msg: "Unable to open email ",
                        );
                      }
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.imagesIconsFeedbackMailIcon),
                        SizedBox(width: 5.w),
                        FittedBox(
                          child: Text(
                            "info@camion-app.com",
                            style: AppStyle.styleRegular18(
                              context,
                            ).copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
