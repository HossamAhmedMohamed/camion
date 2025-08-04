import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/custom_pinput_fields.dart';
import 'package:camion/features/auth/presentation/widgets/repeating_timer_counter.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmPhoneNumberScreen extends StatelessWidget {
  const ConfirmPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 50.h)),

            SliverToBoxAdapter(
              child: Image.asset(
                Assets.imagesForgotPasswordLock,
                width: 225.w,
                height: 216.3.h,
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 15.h)),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      "ادخل رمز المصادقة المرسل علي رقم الجوال 📱",
                      style: AppStyle.styleSemiBold18(context),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  FittedBox(
                    child: Text(
                      "ادخل رمز التحقيق المرسل علي جوالك :",
                      style: AppStyle.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.gray),
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            const SliverToBoxAdapter(child: CustomPinPutField(length: 6)),

            // SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            // SliverToBoxAdapter(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "اعادة الارسال بعد ",
            //         style: AppStyle.styleRegular14(
            //           context,
            //         ).copyWith(color: Colors.grey),
            //       ),

            //       SizedBox(width: 10.w),
            //       const RepeatingTimer(),
            //     ],
            //   ),
            // ),

            // SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            // SliverToBoxAdapter(
            //   child: CustomElevatedButton(
            //    child: Text("المتابعة",  style: AppStyle.styleRegular15(
            //     context,
            //   ).copyWith(color:  Colors.white),),
            //     onPressed: () {
            //       GoRouter.of(context).go(AppRouter.selectingFromBottomNavBar);
            //     },
            //   ),
            // ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
