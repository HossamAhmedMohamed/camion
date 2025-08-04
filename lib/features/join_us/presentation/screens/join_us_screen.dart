import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:camion/features/join_us/presentation/widgets/join_us_image.dart';
import 'package:camion/features/join_us/presentation/widgets/selecting_male_or_female.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
 

class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CustomJoinUsSliverAppBar(
                title: "انضم الينا كمسوق",
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverToBoxAdapter(
                child: Container(
                  decoration: getContainerBoxDecoration(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.h,
                  ),

                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "البيانات الشخصية",
                          style: AppStyle.styleRegular18(context).copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 15.h),

                        JooinUsImage(screenWidth: screenWidth),

                        SizedBox(height: 15.h),

                        const CustomTextFormField(hintText: "الاسم بالكامل"),

                        SizedBox(height: 10.h),

                        const SelectingMaleOrFemale(),

                        SizedBox(height: 10.h),

                        CustomTextFormField(
                          hintText: "الدولة",
                          suffixIcon: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(12.h),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey.shade700,
                                size: 24.r,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        CustomTextFormField(
                          hintText: "الجنسية",
                          suffixIcon: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(12.h),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey.shade700,
                                size: 24.r,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        const SizedBox(
                          height: 200,
                          child: CustomTextFormField(
                            hintText: "نبذة عنك",
                            maxLines: 7,
                            maxLength: 200,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "رابط Fcaebook الخاص بك",
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "رابط Instagram الخاص بك",
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "رابط Tiktok الخاص بك",
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "رابط Snapchat الخاص بك",
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 60.h)),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: CustomElevatedButton(
             child: Text("التالي",   style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),),
              onPressed: () {
               GoRouter.of(context).push(
                  AppRouter.selectSocialMediaOfSupplierScreen,
               );
              },
            ),
          ),
        ],
      ),
    );
  }
}

