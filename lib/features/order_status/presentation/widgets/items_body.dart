import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemsBody extends StatelessWidget {
  const ItemsBody({
    super.key,
    required this.title,
    required this.quantity,
    // required this.totalPrice,
  });

  final DateTime title;
  final int quantity;
  // final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
            "الكمية : $quantity ",
            style: AppStyle.styleRegular14(
              context,
            ).copyWith(color: AppColors.gray),
          ),
    
          SizedBox(height: 8.h),
    
          Row(
            children: [
              Text(
                "تم الطلب في ${DateFormat('d MMMM h:mm a', 'ar').format(title).replaceAll('ص', 'صباحاً').replaceAll('م', 'مساءً')}",
                style: AppStyle.styleRegular14(context).copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
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
        ],
      ),
    );
  }
}
