import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/data/models/profile_model.dart';
import 'package:camion/features/profile/presentation/logic/cubit/log_out_cubit/log_out_cubit.dart';
import 'package:camion/features/profile/presentation/widgets/custom_modal_bottom_sheet_profile.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogOutCubit(),
      child: const ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    List<ProfileModel> profileList = [
      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.myInfo);
        },
        title: 'Personal Information',
        image: Assets.imagesInActiveProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.walletAffiliateCheckScreen);
        },
        title: 'My Wallet',
        image: Assets.imagesArchiveProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.affiliateCheckScreen);
        },
        title: 'Affiliate Marketing',
        image: Assets.imagesPlay,
      ),

      // ProfileModel(
      //   onTap: () {
      //     GoRouter.of(context).push(AppRouter.myWallet);
      //   },
      //   title: 'المحفظة',
      //   image: Assets.imagesEmptyWallet,
      // ),
      // ProfileModel(
      //   onTap: () {
      //     GoRouter.of(context).push(AppRouter.settings);
      //   },
      //   title: 'Settings',
      //   image: Assets.imagesProfileSettings,
      // ),

      // ProfileModel(
      //   onTap: () {},
      //   title: 'تعديل بيانات الحساب',
      //   image: Assets.imagesProfileEdit,
      // ),
      ProfileModel(
        onTap: () {},
        title: 'Rate us',
        image: Assets.imagesIconsStarProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.feedBackScreen);
        },
        title: 'Give us a feedback',
        image: Assets.imagesIconsCalendarBlaaaack,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.privacyScreen);
        },
        title: 'Privacy Policy',
        image: Assets.imagesEmptyWallet,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.help);
        },
        title: 'Help',
        image: Assets.imagesIconsHelp,
      ),

      ProfileModel(
        onTap: () {
          customModalBottomSheetProfile(
            title: "Are you sure you want to log out?",
            subTitle:
                "Logging out will end your current session and you will be redirected to the login screen",
            screenWidth: double.infinity,
            context: context,
            content: Row(
              children: [
                
                
                Expanded(
                  child: CustomElevatedButton(
                    borderColor: AppColors.primaryColor,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primaryColor,
                    child: Text(
                      "Cancel",
                      style: AppStyle.styleRegular15(
                        context,
                      ).copyWith(color: AppColors.primaryColor),
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: CustomElevatedButton(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      "Log out",
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
              ],
            ),
          );
        },
        title: 'Log out',
        image: Assets.imagesLogout,
      ),

      // ProfileModel(
      //   onTap: () {},
      //   title: 'تسجيل الخروج',
      //   image: Assets.imagesLogout,
      // ),
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
        ProfileSliverAppBar(
          title: Text(
            "Profile",
            style: AppStyle.styleRegular18(context),
          ),
          isShoppingCartShown: true,
          leading: const SizedBox(),
          // leading: Container(
          //   // margin: EdgeInsets.only(right: 2.w),
          //   padding: EdgeInsets.all(13.r),
          //   child: GestureDetector(
          //     onTap: () {
          //       GoRouter.of(context).pop();
          //     },
          //     child: Icon(Icons.arrow_back, size: 25.sp, color: Colors.black),
          //   ),
          // ),
        ),

        // SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       left: 20.w,
        //       right: 20.w,
        //       top: screenWidth > 800 ? 30.h : 12.h,
        //     ),
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(16.r),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withAlpha(15),
        //             spreadRadius: 2,
        //             blurRadius: 4,
        //             offset: Offset(0, 2.h),
        //           ),
        //         ],
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(vertical: 8.h),
        //         child: Row(
        //           children: [
        //             SizedBox(
        //               width: 45.w,
        //               height: 45.h,

        //               child: SvgPicture.asset(
        //                 Assets.imagesProfileEdit,
        //                 fit: BoxFit.contain,
        //               ),
        //             ),
        //             SizedBox(width: 12.w),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   "Nihal_Kh",
        //                   style: AppStyle.styleSemiBold18(
        //                     context,
        //                   ).copyWith(color: Colors.black),
        //                 ),
        //                 Text(
        //                   "انضم منذ 3-12-2024",
        //                   style: AppStyle.styleRegular14(
        //                     context,
        //                   ).copyWith(color: Colors.black),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

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
                  // trailing: index == 0
                  //     ? GestureDetector(
                  //         onTap: () {},
                  //         child: Text(
                  //           _languageController.text.isNotEmpty
                  //               ? _languageController.text
                  //               : "اختر اللغة",
                  //           style: AppStyle.styleRegular12(
                  //             context,
                  //           ).copyWith(color: Colors.black),
                  //         ),
                  //       )
                  //     : null,
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

        SliverToBoxAdapter(child: SizedBox(height: 40.h)),

        // SliverToBoxAdapter(
        //   child: GestureDetector(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SvgPicture.asset(
        //           Assets.imagesAccountDelete,
        //           width: 24.w,
        //           height: 24.h,
        //         ),

        //         SizedBox(width: 5.w),

        //         Text(
        //           "حذف الحساب",
        //           style: AppStyle.styleRegular18(context).copyWith(
        //             color: AppColors.primaryColor,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}
