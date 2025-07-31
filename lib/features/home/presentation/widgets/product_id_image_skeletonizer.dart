import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductImageSkeleton extends StatelessWidget {
  const ProductImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16.h,
          left: 16.w,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        /// Dots Indicator
        // Positioned(
        //   bottom: 16.h,
        //   left: 0,
        //   right: 0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(
        //       3,
        //       (index) => Container(
        //         margin: EdgeInsets.symmetric(horizontal: 4.w),
        //         width: index == 0 ? 20.w : 8.w,
        //         height: 8.h,
        //         decoration: BoxDecoration(
        //           color: index == 0
        //               ? Colors.grey.shade400
        //               : Colors.grey.shade300,
        //           borderRadius: BorderRadius.circular(4.r),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        /// Bottom share icon placeholder
        Positioned(
          right: 6.w,
          bottom: 6.h,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductInfoSkeleton extends StatelessWidget {
  const ProductInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: const Text(
                  textDirection: TextDirection.ltr,
                  "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 25.w,
              height: 25.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.save_alt_rounded, color: Colors.red),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        Row(
          children: [
            SizedBox(height: 20.h, width: 60.w, child: const Text("hhhhhhh")),

            // SizedBox(width: 8.w),
            // Shimmer.fromColors(
            //   baseColor: Colors.grey.shade300,
            //   highlightColor: Colors.grey.shade100,
            //   child: Container(
            //     height: 15.h,
            //     width: 40.w,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
