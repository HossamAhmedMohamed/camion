import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              "FeedBack",
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
            child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
          ),

          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Send us your recommendation for a better experience",
                  style: AppStyle.styleBold20(
                    context,
                  ).copyWith(color: AppColors.primaryColor),
                  textAlign: TextAlign.center,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mail: ",
                      style: AppStyle.styleRegular18(
                        context,
                      ).copyWith(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () async {
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
                      child: Text(
                        "info@camion-app.com",
                        style: AppStyle.styleRegular18(context).copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
