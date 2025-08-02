import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridItemBuildingSkeleton extends StatelessWidget {
  const GridItemBuildingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(Assets.imagesShoes, fit: BoxFit.cover),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                  style: AppStyle.styleRegular14(context),
                ),
                SizedBox(height: 14.h),

                // Text("hhhhhhhhh", style: AppStyle.styleRegular14(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("190", style: AppStyle.styleBold16(context)),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              "4.5",
                              style: AppStyle.styleRegular12(context),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.star,
                              color: Colors.grey.shade300,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "hhhhh",
                              style: AppStyle.styleRegular12(context),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),

                      child: Icon(Icons.add, color: Colors.white, size: 22.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
