// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camion/core/utils/app_images.dart';
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

                  child: SvgPicture.asset(
                    currentIndex == 0
                        ? Assets.imagesActiveSearch
                        : Assets.imagesInactiveSearch,

                    width: 24.w,
                    height: 24.h,
                  ),
                ),

                GestureDetector(
                  onTap: () => onTap(1),

                  child: SvgPicture.asset(
                    currentIndex == 1
                        ? Assets.imagesActiveHome
                        : Assets.imagesInActiveHome,

                    width: 24.w,
                    height: 24.h,
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

                  child: SvgPicture.asset(
                    currentIndex == 2
                        ? Assets.imagesActiveBox
                        : Assets.imagesInactiveBox,

                    width: 24.w,
                    height: 24.h,
                  ),
                ),

                GestureDetector(
                  onTap: () => onTap(3),

                  child: SvgPicture.asset(
                    currentIndex == 3
                        ? Assets.imagesActiveProfile
                        : Assets.imagesInActiveProfile,

                    width: 24.w,
                    height: 24.h,
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
