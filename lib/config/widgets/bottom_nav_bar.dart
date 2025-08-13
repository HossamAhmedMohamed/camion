// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final Function(int) onTap;

  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      elevation: 8,
      color: Colors.white,
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
        ),
      ),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => onTap(0),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        currentIndex == 0
                            ? Assets.imagesIconsNewwwwActiveHome
                            : Assets.imagesIconsInactiveHomeIconNewNavbar,

                        width: 24.w,
                        height: 24.h,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "الرئيسية",
                        style: AppStyle.styleRegular14(context).copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: currentIndex == 0
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => onTap(1),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        currentIndex == 1
                            ? Assets.imagesIconsNewwwwwactivetalabaty
                            : Assets
                                  .imagesIconsInactiveOrderStatusNewNavbarIcon,

                        width: 30.w,
                        height: 24.h,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "طلباتي",
                        style: AppStyle.styleRegular14(context).copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: currentIndex == 1
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // GestureDetector(
                //   onTap: () => onTap(2),

                //   child: SvgPicture.asset(
                //     currentIndex == 2
                //         ? Assets.imagesActiveVideoPlay
                //         : Assets.imagesInActiveVideoPlay,

                //     width: 24.w,
                //     height: 24.h,
                //   ),
                // ),
                GestureDetector(
                  onTap: () => onTap(2),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        currentIndex == 2
                            ? Assets.imagesIconsNewwwActiveHeart
                            : Assets.imagesIconsNewwwInactiveHeart,

                        width: 24.w,
                        height: 24.h,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "المفضلة",
                        style: AppStyle.styleRegular14(context).copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: currentIndex == 2
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // GestureDetector(
                //   onTap: () => onTap(3),

                //   child: Stack(
                //     clipBehavior: Clip.none,
                //     children: [
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset(
                //             currentIndex == 3
                //                 ? Assets
                //                       .imagesIconsActiveShoppingCartNewIconNavbar
                //                 : Assets
                //                       .imagesIconsInactiveShoppingCartIconNewNavbar,

                //             width: 26.w,
                //             height: 26.h,
                //           ),

                //           SizedBox(height: 8.h),

                //           Text(
                //             "العربة",
                //             style: AppStyle.styleRegular14(context).copyWith(
                //               fontSize: 14.sp,
                //               fontWeight: FontWeight.w500,
                //               color: currentIndex == 3
                //                   ? AppColors.primaryColor
                //                   : Colors.black,
                //             ),
                //           ),
                //         ],
                //       ),

                //       // BlocBuilder<GetCartCubit, GetCartState>(
                //       //   builder: (context, state) {
                //       //     if (state is GetCartSuccess) {
                //       //       return state.cartList.isEmpty
                //       //           ? Container()
                //       //           : Positioned(
                //       //               top: 1.h,
                //       //               right: 1.w,
                //       //               child: Container(
                //       //                 // width: 10,
                //       //                 // height: 10,
                //       //                 padding: EdgeInsets.all(4.r),
                //       //                 decoration: const BoxDecoration(
                //       //                   shape: BoxShape.circle,
                //       //                   color: AppColors.primaryColor,
                //       //                 ),
                //       //                 child: Text(
                //       //                   state.cartList.length.toString(),
                //       //                   style: AppStyle.styleRegular12(context)
                //       //                       .copyWith(
                //       //                         color: Colors.white,
                //       //                         fontWeight: FontWeight.w500,
                //       //                       ),
                //       //                 ),
                //       //               ),
                //       //             );
                //       //     }
                //       //     return Container();
                //       //   },
                //       // ),
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () => onTap(3),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        currentIndex == 3
                            ? Assets.imagesActiveProfile
                            : Assets.imagesInActiveProfile,

                        width: 24.w,
                        height: 24.h,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "حسابي",
                        style: AppStyle.styleRegular14(context).copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: currentIndex == 3
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
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
