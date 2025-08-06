import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/join_us_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

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
              "تعديل بياناتك",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),

            isShownDivider: true,
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
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SvgPicture.asset(
                  width: 26.w,
                  height: 26.h,
                  Assets.imagesIconsActiveEditInfo,
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تعديل الصورة الشخصية",
                    style: AppStyle.styleBold16(context),
                  ),

                  JooinUsImage(
                    image: Assets.imagesIconsEditInfo,
                    screenWidth: screenWidth,
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "تعديل البيانات الشخصية",
                    style: AppStyle.styleBold16(context),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                        "الاسم",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(width: 15.w),

                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  const CustomTextFormField(
                    enabled: false,
                    initialValue: "محمد صلاح",
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                        "البريد الالكتروني",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(width: 15.w),

                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  const CustomTextFormField(
                    enabled: false,
                    initialValue: "محمد صلاح",
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                        "رقم الهاتف",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(width: 15.w),

                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  const CustomTextFormField(
                    enabled: false,
                    initialValue: "محمد صلاح",
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
