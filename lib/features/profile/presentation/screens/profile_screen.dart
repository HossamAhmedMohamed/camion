 
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/data/models/profile_model.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:camion/features/profile/presentation/logic/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:camion/features/profile/presentation/logic/cubit/log_out_cubit/log_out_cubit.dart';
import 'package:camion/features/profile/presentation/widgets/custom_modal_bottom_sheet_profile.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogOutCubit()),
        BlocProvider(
          create: (context) => DeleteAccountCubit(sl<ProfileRepository>()),
        ),
      ],
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
        title: S.of(context).personal_information,
        image: Assets.imagesInActiveProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.walletAffiliateCheckScreen);
        },
        title: S.of(context).my_wallet,
        image: Assets.imagesArchiveProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.affiliateCheckScreen);
        },
        title: S.of(context).affiliate_marketing,
        image: Assets.imagesPlay,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.changeLanuage);
        },
        title: S.of(context).language,
        image: Assets.imagesGlobal,
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
        title: S.of(context).rate_us,
        image: Assets.imagesIconsStarProfile,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.feedBackScreen);
        },
        title: S.of(context).give_us_feedback,
        image: Assets.imagesIconsCalendarBlaaaack,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.privacyScreen);
        },
        title: S.of(context).privacy_policy,
        image: Assets.imagesEmptyWallet,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.help);
        },
        title: S.of(context).help,
        image: Assets.imagesIconsHelp,
      ),

      ProfileModel(
        onTap: () {
          customModalBottomSheetProfile(
            title: S.of(context).are_you_sure_you_want_to_logout,
            subTitle: S.of(context).logout_description,
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
                      S.of(context).cancel,
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
                      S.of(context).logout,
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
        title: S.of(context).logout,
        image: Assets.imagesLogout,
      ),

      ProfileModel(
        onTap: () {
          customModalBottomSheetProfile(
            title: S.of(context).are_you_sure_you_want_to_delete,
            subTitle: S.of(context).delete_account_description,
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
                      S.of(context).cancel,
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
                  child: BlocProvider.value(
                    value: context.read<DeleteAccountCubit>(),

                    child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
                      listener: (context, state) {
                        if (state is DeleteAccountLoading) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        } else {
                          // hide loading indicator
                          GoRouter.of(context).pop();
                        }

                        if (state is DeleteAccountSuccess) {
                          GoRouter.of(context).goNamed(AppRouter.login);
                        }

                        if (state is DeleteAccountFailure) {
                          Fluttertoast.showToast(
                            msg: state.error.message,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.sp,
                          );
                        }
                      },
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          S.of(context).delete_account,
                          style: AppStyle.styleRegular15(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                        onPressed: () {
                          context.read<DeleteAccountCubit>().deleteAccount();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        title: S.of(context).delete_account,
        image: Assets.imagesAccountDelete,
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
            S.of(context).profile,
            style: AppStyle.styleRegular18(context),
          ),
          isShoppingCartShown: true,
          leading: const SizedBox(),
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
                  // trailing: index == 3
                  //     ? GestureDetector(
                  //         onTap: () {},
                  //         child: Text(
                  //           context
                  //               .read<LocalizationsCubit>()
                  //               .state
                  //               .languageCode,
                  //           style: AppStyle.styleRegular14(
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
