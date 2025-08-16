import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/presentation/logic/cubit/log_out_cubit/log_out_cubit.dart';
import 'package:camion/features/profile/presentation/widgets/custom_modal_bottom_sheet_profile.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              "اعدادات الحساب",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black),
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
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: screenWidth > 800 ? 30.h : 12.h,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    customModalBottomSheetProfile(
                      title: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
                      subTitle:
                          "سيتم إنهاء جلستك الحالية، وستحتاج إلى تسجيل الدخول مرة أخرى للوصول إلى حسابك.",
                      screenWidth: screenWidth,
                      context: context,
                      content: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                "تسجيل الخروج",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                              onPressed: () {
                                context.read<LogOutCubit>().logOut();
                                GoRouter.of(context).goNamed(AppRouter.login);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomElevatedButton(
                              borderColor: AppColors.primaryColor,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.primaryColor,
                              child: Text(
                                " الغاء",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    Assets.imagesLogout,
                    width: 25.w,
                    height: 25.h,
                  ),
                  title: Text(
                    "تسجيل الخروج",
                    style: AppStyle.styleSemiBold15(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: screenWidth > 800 ? 30.h : 15.h),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: screenWidth > 800 ? 30.h : 12.h,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    customModalBottomSheetProfile(
                      title: "هل أنت متأكد من رغبتك في حذف حسابك؟",
                      subTitle:
                          "سيتم حذف جميع بياناتك نهائيًا، ولن تتمكن من استعادتها لاحقًا. هذا الإجراء لا يمكن التراجع عنه.",
                      screenWidth: screenWidth,
                      context: context,
                      content: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                "حذف الحساب",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomElevatedButton(
                              borderColor: AppColors.primaryColor,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.primaryColor,
                              child: Text(
                                " الغاء",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    Assets.imagesAccountDelete,
                    width: 30.w,
                    height: 30.h,
                  ),
                  title: Text(
                    "الغاء الحساب",
                    style: AppStyle.styleSemiBold15(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
