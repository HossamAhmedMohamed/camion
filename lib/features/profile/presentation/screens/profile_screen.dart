import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/data/models/profile_model.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileModel> profileList = [
    ProfileModel(title: 'تغيير اللغة', image: Assets.imagesGlobal),
    ProfileModel(title: 'المحفظة', image: Assets.imagesEmptyWallet),

    ProfileModel(title: 'التسويق بالعمولة', image: Assets.imagesPlay),

    ProfileModel(title: 'محفوظاتي', image: Assets.imagesArchiveProfile),

    ProfileModel(title: 'تعديل بيانات الحساب', image: Assets.imagesProfileEdit),

    ProfileModel(title: 'تسجيل الخروج', image: Assets.imagesLogout),
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        const ProfileSliverAppBar(),

        // SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: screenWidth > 800 ? 30.h : 12.h,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 75.w,
                      height: 75.h,

                      child: Image.asset(
                        Assets.imagesWoman,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nihal_Kh",
                          style: AppStyle.styleSemiBold18(
                            context,
                          ).copyWith(color: Colors.black),
                        ),
                        Text(
                          "انضم منذ 3-12-2024",
                          style: AppStyle.styleRegular14(
                            context,
                          ).copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                  trailing: index == 0
                      ? GestureDetector(
                          onTap: () {},
                          child: Text(
                            "العربية",
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

        SliverToBoxAdapter(child: SizedBox(height: 40.h)),

        SliverToBoxAdapter(
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.imagesAccountDelete,
                  width: 24.w,
                  height: 24.h,
                ),

                SizedBox(width: 5.w),

                Text(
                  "حذف الحساب",
                  style: AppStyle.styleRegular18(context).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
