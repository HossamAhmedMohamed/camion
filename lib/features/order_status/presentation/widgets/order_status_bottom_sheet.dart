import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:camion/features/order_status/presentation/widgets/order_status_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusBottomSheet extends StatelessWidget {
  final List<OrderStatusItemModel> trackingItems;

  const OrderStatusBottomSheet({super.key, required this.trackingItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header with close button
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 20.w,
              top: 16.h,
              bottom: 16.h,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: AppColors.black),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Order Status",
                      style: AppStyle.styleRegular18(context).copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24.w), // To balance the close button
              ],
            ),
          ),

          // Tracking Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: trackingItems.length,
              itemBuilder: (context, index) => OrderStatusItemWidget(
                item: trackingItems[index],
                isCurrent: index < trackingItems.length - 1
                    ? trackingItems[index].isCompleted &&
                          trackingItems[index + 1].isCompleted
                    : false,

                isFirst: index == 0,
                isLast: index == trackingItems.length - 1,
                // isCurrent: index == trackingItems.length - 2, // Assuming last item is current
              ),
            ),
          ),
        ],
      ),
    );
  }
}
