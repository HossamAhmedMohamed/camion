import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageSkeleton extends StatelessWidget {
  const ProductImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      width: double.infinity,
      child: Image.asset(
        fit: BoxFit.fill,
        Assets.imagesShoes));
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
