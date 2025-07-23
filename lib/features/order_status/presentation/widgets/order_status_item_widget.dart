import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusItemWidget extends StatelessWidget {
  final OrderStatusItemModel item;
  final bool isLast;

  const OrderStatusItemWidget({
    super.key,
    required this.item,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             
            Column(
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.isCompleted
                        ? AppColors.green
                        : Colors.transparent,
                    border: item.isCompleted
                        ? null
                        : Border.all(
                            color: item.isActive
                                ? AppColors.primaryColor
                                : AppColors.gray.withAlpha(100),
                            width: 2.w,
                          ),
                  ),
                  child: item.isCompleted
                      ? Icon(Icons.check, color: AppColors.white, size: 16.sp)
                      : null,
                ),

                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 40.h,
                    color: item.isCompleted
                        ? AppColors.green.withAlpha(100)
                        : AppColors.gray.withAlpha(100),
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                  ),
              ],
            ),

            SizedBox(width: 15.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: AppStyle.styleRegular14(context).copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (item.time != null)
                        Text(
                          item.time!,
                          style: AppStyle.styleRegular14(
                            context,
                          ).copyWith(color: AppColors.gray),
                        ),
                    ],
                  ),

                  if (item.subtitle.isNotEmpty) ...[
                    SizedBox(height: 5.h),
                    Text(
                      item.subtitle,
                      style: AppStyle.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.gray),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),

        if (!isLast) SizedBox(height: 10.h),
      ],
    );
  }
}
