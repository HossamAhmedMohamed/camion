import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/data/models/profile_model.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<ProfileModel> profileList = [
      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.changeLanuage);
        },
        title: 'Change Language',
        image: Assets.imagesGlobal,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.help);
        },
        title: 'Help',
        image: Assets.imagesIconsHelp,
      ),

      // ProfileModel(
      //   onTap: () {
      //     GoRouter.of(context).push(AppRouter.accountSettings);
      //   },
      //   title: 'اعدادات الحساب',
      //   image: Assets.imagesProfileEdit,
      // ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              "Settings",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),

            actions: const [],

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
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverList.builder(
            itemCount: profileList.length,

            itemBuilder: (context, index) {
              return Padding(
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
                    onTap: profileList[index].onTap,
                    trailing: index == 0
                        ? GestureDetector(
                            onTap: () {},
                            child: Text(
                              "اختر اللغة",
                              style: AppStyle.styleRegular12(
                                context,
                              ).copyWith(color: Colors.black),
                            ),
                          )
                        : null,
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      profileList[index].image,
                      width: 25.w,
                      height: 25.h,
                    ),
                    title: Text(
                      profileList[index].title,
                      style: AppStyle.styleSemiBold15(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
