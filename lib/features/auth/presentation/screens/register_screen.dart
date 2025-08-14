 
 
import 'package:camion/features/auth/presentation/widgets/camion_logo.dart';
import 'package:camion/features/auth/presentation/widgets/register_form.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 60.h)),

            const SliverToBoxAdapter(child: CamionLogo()),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            const SliverToBoxAdapter(
              child: RegisterForm(),
            ),

            // SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            // SliverToBoxAdapter(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(height: 1.h, color: Colors.grey),
            //       ),

            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.w),
            //         child: Text(
            //           "أو",
            //           style: AppStyle.styleRegular14(
            //             context,
            //           ).copyWith(color: Colors.black),
            //         ),
            //       ),

            //       Expanded(
            //         child: Container(height: 1.h, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),

            // SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            // SliverToBoxAdapter(
            //   child: CustomSelectingMethods(
            //     onTap: () {},
            //     logo: Assets.imagesLogosFacebook,
            //     text: 'الاستمرار ب Facebook',
            //   ),
            // ),

            // SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            // SliverToBoxAdapter(
            //   child: CustomSelectingMethods(
            //     onTap: () {},
            //     logo: Assets.imagesGoogleIcon,
            //     text: 'الاستمرار ب Google',
            //   ),
            // ),

            // SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            // SliverToBoxAdapter(
            //   child: CustomSelectingMethods(
            //     onTap: () {},
            //     logo: Assets.imagesAppleIcon,
            //     text: 'الاستمرار ب Apple',
            //   ),
            // ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).pushNamed(AppRouter.login);
                            },
                          text: "Login",
                          style: TextStyle(
                            color: const Color(0xFFB92123),
                            decoration: TextDecoration.underline,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}

