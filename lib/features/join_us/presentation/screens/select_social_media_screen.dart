import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/data/models/social_media_selecting_model.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_social_media_selecting_cubit.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectSocialMediaScreen extends StatelessWidget {
  const SelectSocialMediaScreen({super.key});

  static List<SocialMediaSelectingModel> socialMedia = [
    SocialMediaSelectingModel(
      title: "فيسبوك",
      socialMediaLogo: Assets.imagesLogosFacebook,
      selectingCheckBox: false,
    ),
    SocialMediaSelectingModel(
      title: "جوجل",
      socialMediaLogo: Assets.imagesGoogleIcon,
      selectingCheckBox: false,
    ),
    SocialMediaSelectingModel(
      title: "سناب شات",
      socialMediaLogo: Assets.imagesSnapChat,
      selectingCheckBox: false,
    ),

    SocialMediaSelectingModel(
      title: "انستجرام",
      socialMediaLogo: Assets.imagesInstagram,
      selectingCheckBox: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CustomJoinUsSliverAppBar(title: "انضم الينا كمسوق"),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "اي من المنصات التالية تفضل وضع اعلاناتك بها",
                    style: AppStyle.styleRegular15(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              SliverList.builder(
                itemCount: socialMedia.length,
                itemBuilder: (context, index) {
                  return BlocSelector<
                    ToggleSocialMediaSelectingCubit,
                    ToggleSocialMediaSelectingState,
                    bool
                  >(
                    selector: (state) => state.selectedIndexes.contains(index),
                    builder: (context, isSelected) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ToggleSocialMediaSelectingCubit>()
                              .toggle(index);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withAlpha(15)
                                : AppColors.backgroundGray,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            children: [
                              index == 2
                                  ? Image.asset(Assets.imagesSnapChatPng)
                                  : SvgPicture.asset(
                                      socialMedia[index].socialMediaLogo,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  socialMedia[index].title,
                                  style: AppStyle.styleRegular14(context)
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              SvgPicture.asset(
                                isSelected
                                    ? Assets.imagesSelectedCheckbox
                                    : Assets.imagesNotSelectedCheckbox,
                                width: 24.w,
                                height: 24.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),

          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: CustomElevatedButton(text: "التالي", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
