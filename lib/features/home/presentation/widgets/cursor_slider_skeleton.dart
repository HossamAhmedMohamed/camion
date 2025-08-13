import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CursorSliderSkeletonizer extends StatelessWidget {
  const CursorSliderSkeletonizer({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
    items: List.generate(3, (index) {
      return Padding(
        padding: EdgeInsets.only(
          right: 15.w,
          left: index == 2 ? 15.w : 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesIconsNewDiscounts),
              ),
            ),
            // child: Image.asset(
            //   Assets.imagesIconsNewDiscounts,
            //   fit: BoxFit.contain,
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 11.w,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  // height: 32.h,
                  width: screenWidth > 800 ? 170.w : 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                  ),
    
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "اطلب الان",
                        style: AppStyle.styleRegular12(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }),
    options: CarouselOptions(
      // height: 200.h,
      padEnds: false,
      aspectRatio: 350.w / 162.h,
      viewportFraction: 0.9,
      initialPage: 0,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: true,
      enlargeCenterPage: true,
      enlargeFactor: 0.1,
      onPageChanged: (int index, CarouselPageChangedReason reason) =>
          context.read<ToggleProductIdImagesCubit>().toggle(index),
      scrollDirection: Axis.horizontal,
    ),
                );
  }
}
