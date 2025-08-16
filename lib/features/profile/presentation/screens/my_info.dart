import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/presentation/logic/cubit/get_user_cubit/get_user_cubit.dart';
import 'package:camion/features/profile/presentation/widgets/custom_info_sliver_app_bar.dart';
import 'package:camion/features/profile/presentation/widgets/profile_affiliate_or_not_affiliate.dart';
import 'package:camion/features/profile/presentation/widgets/profile_loading_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  static final GlobalKey<MyInfoScreenBodyState> profileKey =
      GlobalKey<MyInfoScreenBodyState>();

  @override
  Widget build(BuildContext context) {
    return MyInfoScreenBody(key: profileKey);
  }
}

class MyInfoScreenBody extends StatefulWidget {
  const MyInfoScreenBody({super.key});
  @override
  State<MyInfoScreenBody> createState() => MyInfoScreenBodyState();
}

class MyInfoScreenBodyState extends State<MyInfoScreenBody> {
  @override
  void initState() {
    context.read<GetUserCubit>().getUserById();
    super.initState();
  }

  refreshGetUser() => context.read<GetUserCubit>().getUserById();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<GetUserCubit, GetUserState>(
        builder: (context, state) {
          if (state is GetUserLoading) {
            return const Skeletonizer(
              enabled: true,
              child: ProfileLoadingSkeletonizer(),
            );
          }

          if (state is GetUserLoaded) {
            final user = state.user;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                CustomInfoSliverAppBar(
                  fullName: user.fullName,
                  email: user.email,
                  phone: user.phone,
                ),

                SliverToBoxAdapter(child: SizedBox(height: 25.h)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("صورتك الشخصية", style: AppStyle.styleBold16(context)),

                        // Center(
                        //   child: Image.asset(
                        //     Assets.imagesPhotoJoinUs,
                        //     height: 150.h,
                        //     width: 150.w,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                        SizedBox(height: 20.h),

                        // Text(
                        //   "",
                        //   style: AppStyle.styleBold16(context),
                        // ),
                        SizedBox(height: 20.h),

                        Text(
                          "Full Name",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: Colors.black),
                        ),

                        SizedBox(height: 8.h),

                        CustomTextFormField(
                          enabled: false,
                          initialValue: user.fullName,
                        ),

                        SizedBox(height: 20.h),

                        Text(
                          "Email",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: Colors.black),
                        ),

                        SizedBox(height: 8.h),

                        CustomTextFormField(
                          enabled: false,
                          initialValue: user.email,
                        ),

                        SizedBox(height: 20.h),

                        Text(
                          "Phone Number",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: Colors.black),
                        ),

                        SizedBox(height: 8.h),

                        CustomTextFormField(
                          enabled: false,
                          initialValue: user.phone,
                        ),

                        SizedBox(height: 30.h),

                        user.role == "affiliate"
                            ? const ProfileAffiliateShown()
                            : const ProfileNotaffiliateShown(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is GetUserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(state.error.icon, color: Colors.red, size: 50),

                  SizedBox(height: 20.h),
                  Text(
                    state.error.message,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10.h),

                  ElevatedButton(
                    onPressed: () {
                      context.read<GetUserCubit>().getUserById();
                    },
                    child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
