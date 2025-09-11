 
 
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/camion_logo.dart';
import 'package:camion/features/auth/presentation/widgets/login_form.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 60.h)),

            const SliverToBoxAdapter(child: CamionLogo()),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            const SliverToBoxAdapter(
              child: LoginForm(),
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
                          text: "${S.of(context).dont_have_an_account} ",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(
                                context,
                              ).pushNamed(AppRouter.register);
                            },
                          text:  S.of(context).register,
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: const Color(0xFFB92123),
                            decoration: TextDecoration.underline,
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

