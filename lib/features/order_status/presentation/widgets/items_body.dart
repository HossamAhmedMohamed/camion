import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemsBody extends StatelessWidget {
  const ItemsBody({
    super.key,
    required this.title,
    required this.numberOfProducts,
    required this.totalPrice,
  });

  final String? totalPrice;
  final DateTime title;
  final int numberOfProducts;
  // final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 2,
        //   style: AppStyle.styleRegular14(context).copyWith(
        //     color: AppColors.black,
        //     fontWeight: FontWeight.w700,
        //   ),
        //    textDirection: TextDirection.ltr,
        // ),
        // SizedBox(height: 8.h),
        Text(
          "Number of products : $numberOfProducts ",
          style: AppStyle.styleRegular14(
            context,
          ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
        ),

        SizedBox(height: 8.h),

        Row(
          children: [
            Text(
              "Ordered in ${DateFormat('d MMMM h:mm a', 'en').format(title).replaceAll('ص', 'صباحاً').replaceAll('م', 'مساءً')}",
              style: AppStyle.styleRegular14(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            // SizedBox(width: 5.w),

            // Text(
            //   "$totalPrice",
            //   style: AppStyle.styleRegular18(context).copyWith(
            //     color: AppColors.primaryColor,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        ),

        // SizedBox(height: 10.h),

        
      ],
    );
  }
}
