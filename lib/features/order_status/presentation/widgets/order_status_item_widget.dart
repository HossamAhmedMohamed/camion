import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:intl/intl.dart';

class OrderStatusItemWidget extends StatelessWidget {
  final OrderStatusItemModel item;
  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  const OrderStatusItemWidget({
    super.key,
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isCurrent,
    // this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step indicator and line
        Column(
          children: [
            // Circle indicator
            Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.isCompleted
                    ? AppColors.primaryColor
                    : AppColors.gray.withAlpha(127),
              ),
            ),
            // Vertical line
            if (!isLast)
              Container(
                width: 2.w,
                height: 80.h,
                color: isCurrent ? AppColors.primaryColor : AppColors.gray.withAlpha(70),
              ),
          ],
        ),

        SizedBox(width: 16.w),

        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: AppStyle.styleRegular16(context).copyWith(
                        color: item.isCompleted ? AppColors.black : AppColors.gray,
                        fontWeight: item.isCompleted
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),

                    Text(
                      DateFormat('h:mm a').format(item.time ?? DateTime.now()),
                      style: AppStyle.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.gray.withAlpha(178)),
                    ),
                  ],
                ),

                // SizedBox(height: 4.h),

                // Date and time

                // Description if exists
                if (item.subtitle.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.subtitle,
                    style: AppStyle.styleRegular14(
                      context,
                    ).copyWith(color: AppColors.gray.withAlpha(200)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
