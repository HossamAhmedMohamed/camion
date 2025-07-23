import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:camion/features/order_status/presentation/widgets/order_status_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Model للبيانات

class OrderStatusBottomSheet extends StatelessWidget {
  final List<OrderStatusItemModel> trackingItems;

  const OrderStatusBottomSheet({super.key, required this.trackingItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: AppColors.black),
                ),
                Text(
                  "تتبع الطلب",
                  style: AppStyle.styleRegular18(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 24.w), // للتوازن
              ],
            ),
          ),

          // Divider
          Divider(height: 1.h, color: AppColors.gray.withAlpha(100)),

          // Tracking Items
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: List.generate(
                  trackingItems.length,
                  (index) => OrderStatusItemWidget(
                    item: trackingItems[index],
                    isLast: index == trackingItems.length - 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
