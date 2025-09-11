import 'package:camion/config/localization/cubit/localizations_cubit.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeJoinUsNow extends StatelessWidget {
  const HomeJoinUsNow({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 374.h / 180.w,
        child: Container(
          // height: screenWidth > 800 ? 260.h : 180.h,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.imagesIconsJoinAffiliateTranslate),
            ),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment:
                  context.watch<LocalizationsCubit>().state.languageCode == 'ar '
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 15.h,
                        left: 10.w,
                        right: 10.w,
                      ),
                      child: FittedBox(
                        child: Text(
                          S.of(context).join_our_team,
                          style: AppStyle.styleBold14(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            
                SizedBox(height: 10.h),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Text(
                    S.of(context).join_our_team_description,
                    style: AppStyle.styleRegular12(
                      context,
                    ).copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 15.h,
                        left: 50.w,
                        right: 50.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment:
                            context
                                    .watch<LocalizationsCubit>()
                                    .state
                                    .languageCode ==
                                'ar '
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(AppRouter.affiliateCheckScreen);
                            },
                            child: Container(
                              // height: 32.h,
                              width: screenWidth > 800 ? 170.w : 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.primaryColor,
                              ),
            
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 8.w,
                                ),
                                child: FittedBox(
                                  // fit: BoxFit.scaleDown,
                                  child: Text(
                                    S.of(context).join_us,
                                    style: AppStyle.styleRegular14(
                                      context,
                                    ).copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
