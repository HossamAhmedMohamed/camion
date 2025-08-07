import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/data/models/change_language_model.dart';
import 'package:camion/features/profile/presentation/widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  static List<ChangeLanguageModel> languages = [
    ChangeLanguageModel(languageCode: 'ar', onTap: () {}, title: 'العربية'),

    ChangeLanguageModel(languageCode: 'en', onTap: () {}, title: 'الانجليزية'),
  ];

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  int selectedLanguage = -1;
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
              "تغيير اللغة",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: AppColors.black, size: 24.r),
            ),
            actions: const [],
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: Text(
              "اختر اللغة",
              style: AppStyle.styleRegular16(
                context,
              ).copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverList.builder(
            itemCount: ChangeLanguageScreen.languages.length,

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
                    onTap: () {
                      setState(() {
                        selectedLanguage = index;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    trailing: CustomRadio(
                      isSelected: selectedLanguage == index,
                    ),
                    title: Text(
                      ChangeLanguageScreen.languages[index].title,
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
