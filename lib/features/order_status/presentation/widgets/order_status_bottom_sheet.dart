import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/order_tracking_cubit/order_tracking_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/order_status_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusBottomSheet extends StatelessWidget {
  const OrderStatusBottomSheet({
    super.key,
    required this.trackingItems,
    required this.orderId,
  });
  final List<OrderStatusItemModel> trackingItems;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingCubit(sl<OrderStatusRepository>()),
      child: OrderStatusBottomSheetBody(
        trackingItems: trackingItems,
        orderId: orderId,
      ),
    );
  }
}

class OrderStatusBottomSheetBody extends StatefulWidget {
  final List<OrderStatusItemModel> trackingItems;
  final String orderId;

  const OrderStatusBottomSheetBody({
    super.key,
    required this.trackingItems,
    required this.orderId,
  });

  @override
  State<OrderStatusBottomSheetBody> createState() =>
      _OrderStatusBottomSheetBodyState();
}

class _OrderStatusBottomSheetBodyState
    extends State<OrderStatusBottomSheetBody> {
  // @override
  // void initState() {
  //   context.read<OrderTrackingCubit>().getOrderTracking(
  //     orderId: widget.orderId,
  //   );
  //   super.initState();
  // }

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
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    itemCount: widget.trackingItems.length,
                    itemBuilder: (context, index) => OrderStatusItemWidget(
                      item: widget.trackingItems[index],
                      isCurrent: index < widget.trackingItems.length - 1
                          ? widget.trackingItems[index].isCompleted &&
                                widget.trackingItems[index + 1].isCompleted
                          : false,

                      isFirst: index == 0,
                      isLast: index == widget.trackingItems.length - 1,
                      // isCurrent: index == trackingItems.length - 2, // Assuming last item is current
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
