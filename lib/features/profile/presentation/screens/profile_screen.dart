import 'dart:developer';

import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/all_contries_and_language_list.dart';
import 'package:camion/features/profile/data/models/profile_model.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _languageController = TextEditingController();
  void _showCountryPicker() async {
    final selectedLanguage = await showModalBottomSheet<String>(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        TextEditingController localSearchController = TextEditingController();

        List<String> localFilteredLanguages = List.from(popularLanguages);

        return StatefulBuilder(
          builder: (context, setModalState) {
            void filterLocal(String query) {
              setModalState(() {
                if (query.isEmpty) {
                  localFilteredLanguages = List.from(popularLanguages);
                } else {
                  final searchQuery = query.trim();
                  localFilteredLanguages = popularLanguages.where((language) {
                    final cleanLanguage = language.trim();
                    final cleanQuery = searchQuery;

                    return cleanLanguage.contains(cleanQuery) ||
                        cleanLanguage.toLowerCase().contains(
                          cleanQuery.toLowerCase(),
                        );
                  }).toList();
                }
              });
            }

            localSearchController.addListener(() {
              final value = localSearchController.text;

              filterLocal(value);
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // SizedBox(height: 200.h),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: CustomTextFormField(
                    fieldColor: AppColors.primaryColor,
                    hintText: "ما هي لغتك",
                    controller: localSearchController,

                    prefixIcon: Icon(Icons.search, size: 24.sp),
                  ),
                ),
                Expanded(
                  child: localFilteredLanguages.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: AppStyle.styleSemiBold18(context),
                          ),
                        )
                      : ListView.builder(
                          itemCount: localFilteredLanguages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                localFilteredLanguages[index],
                                textAlign: TextAlign.left,
                              ),
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).pop(localFilteredLanguages[index]);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedLanguage != null) {
      setState(() {
        _languageController.text = selectedLanguage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("ProfileScreen build");
    List<ProfileModel> profileList = [
      ProfileModel(
        onTap: () {
          _showCountryPicker();
        },
        title: 'تغيير اللغة',
        image: Assets.imagesGlobal,
      ),
      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.myWallet);
        },
        title: 'المحفظة',
        image: Assets.imagesEmptyWallet,
      ),

      ProfileModel(
        onTap: () {
          GoRouter.of(context).push(AppRouter.supplierWelcome);
        },
        title: 'التسويق بالعمولة',
        image: Assets.imagesPlay,
      ),

      ProfileModel(
        onTap: () {},
        title: 'محفوظاتي',
        image: Assets.imagesArchiveProfile,
      ),

      ProfileModel(
        onTap: () {},
        title: 'تعديل بيانات الحساب',
        image: Assets.imagesProfileEdit,
      ),

      ProfileModel(
        onTap: () {},
        title: 'تسجيل الخروج',
        image: Assets.imagesLogout,
      ),
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        ProfileSliverAppBar(
          title: Image.asset(
            Assets.imagesCamionLogo,
            width: 65.w,
            height: 50.h,
          ),
          isShoppingCartShown: true,
          leading: Container(
            // margin: EdgeInsets.only(right: 2.w),
            padding: EdgeInsets.all(13.r),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(Assets.imagesProfileSettings),
            ),
          ),
        ),

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
                  onTap: profileList[index].onTap,
                  trailing: index == 0
                      ? GestureDetector(
                          onTap: () {},
                          child: Text(
                            _languageController.text.isNotEmpty
                                ? _languageController.text
                                : "اختر اللغة",
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

        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}
