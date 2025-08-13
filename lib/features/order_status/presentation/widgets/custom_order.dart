import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:camion/features/order_status/presentation/widgets/items_body.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomOrder extends StatelessWidget {
  const CustomOrder({
    super.key,
    required this.totalPrice,
    required this.quantity,
    required this.date,
    required this.numberOfRequest,
  });
  final String numberOfRequest;
  final String totalPrice;
  final int quantity;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getContainerBoxDecoration(),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.mintGreen,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "جاري التوصيل",
                  style: AppStyle.styleRegular12(context).copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Text(
                "سيصل خلال ايام ",
                style: AppStyle.styleRegular14(
                  context,
                ).copyWith(color: AppColors.gray),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          Row(
            children: [
              ItemsBody(
                title: date,
                quantity: quantity,
                // totalPrice: "120",
              ),

              Row(
                children: [
                  Text(
                    "اجمالي:",
                    style: AppStyle.styleRegular14(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.w),

                  Text(
                    totalPrice,
                    style: AppStyle.styleRegular18(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          const Row(
            children: [Expanded(child: Divider(color: AppColors.fogGray))],
          ),
          // SizedBox(height: 20.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Spacer(),
          //     Expanded(
          //       flex: 2,
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: CustomElevatedButton(
          //               backgroundColor: AppColors.primaryColor,
          //               onPressed: () {
          //                 showOrderTrackingModal(context);
          //               },
          //               verticalPadding: 5.h,
          //               child: Text(
          //                 "تتبع الطلب",
          //                 style: AppStyle.styleRegular15(
          //                   context,
          //                 ).copyWith(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //           SizedBox(width: 10.w),
          //           Expanded(
          //             child: CustomElevatedButton(
          //               borderColor: AppColors.primaryColor,
          //               backgroundColor: AppColors.white,
          //               onPressed: () {
          //                 GoRouter.of(context).push(AppRouter.orderDetails);
          //               },
          //               verticalPadding: 5.h,
          //               child: Text(
          //                 "تفاصيل الطلب",
          //                 style: AppStyle.styleRegular15(
          //                   context,
          //                 ).copyWith(color: AppColors.primaryColor),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
