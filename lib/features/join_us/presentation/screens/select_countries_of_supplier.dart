import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_modal_bottom_sheet.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_social_media_selecting_cubit.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCountriesOfSupplier extends StatelessWidget {
  const SelectCountriesOfSupplier({super.key});

  static const List<String> countries = [
    "مصر",
    "السعودية",
    "الامارات",
    "الكويت",
    "قطر",
    "البحرين",
    "عمان",
    "العراق",
    "الأردن",
    "فلسطين",
    "لبنان",
    "سوريا",
    "اليمن",
    "السودان",
    "ليبيا",
    "تونس",
    "الجزائر",
    "المغرب",
    "موريتانيا",
    "الصومال",
    "جيبوتي",
    "جزر القمر",
  ];
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
              const CustomJoinUsSliverAppBar(title: "انضم الينا كمسوق"),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "اي من الدول التالية تفضل نشر اعلاناتك بها",
                    style: AppStyle.styleRegular15(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 25.h)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.h,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double availableWidth = constraints.maxWidth;

                      double itemMinWidth = 100;
                      double spacing = 10.w;

                      int itemsPerRow =
                          ((availableWidth + spacing) /
                                  (itemMinWidth + spacing))
                              .floor();
                      itemsPerRow = itemsPerRow.clamp(2, 6);

                      double itemWidth =
                          (availableWidth - (spacing * (itemsPerRow - 1))) /
                          itemsPerRow;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: 15.h,
                        children: List.generate(countries.length, (index) {
                          return BlocSelector<
                            ToggleSocialMediaSelectingCubit,
                            ToggleSocialMediaSelectingState,
                            bool
                          >(
                            selector: (state) {
                              return state.selectedIndexes.contains(index);
                            },
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<ToggleSocialMediaSelectingCubit>()
                                      .toggle(index);
                                },
                                child: Container(
                                  width: itemWidth,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
                                  ),

                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(
                                        color: state
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                        width: 1.5.w,
                                      ),
                                    ),
                                    color: state
                                        ? AppColors.primaryColor.withAlpha(15)
                                        : AppColors.lightGray,
                                  ),

                                  child: Column(
                                    children: [
                                      Icon(
                                        size: 35.r,
                                        color: state
                                            ? AppColors.primaryColor
                                            : AppColors.gray,
                                        Icons.place_outlined,
                                      ),

                                      SizedBox(height: 8.h),

                                      Text(
                                        countries[index],
                                        style: AppStyle.styleRegular14(context)
                                            .copyWith(
                                              color: state
                                                  ? AppColors.primaryColor
                                                  : AppColors.gray,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),

          Positioned(
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
            child: CustomElevatedButton(
              text: "ارسال طلب الانضمام",
              onPressed: () {
                customizeModalBottomSheet(
                  title: "لقد تم ارسال طلب الانضمام بنجاح",
                  content: CustomElevatedButton(
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    text: "الذهاب للرئيسية",
                    onPressed: () {},
                  ),
                  screenWidth: screenWidth,
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
