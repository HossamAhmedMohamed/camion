import 'dart:developer';

import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/items_body.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CustomOrder extends StatefulWidget {
  const CustomOrder({
    super.key,
    required this.totalPrice,
    required this.numberOfProducts,
    required this.date,
    required this.numberOfRequest,
    required this.onTapOnOrderDetails,
    required this.isOrderShipped,
    required this.isOrderPaied,
    required this.orderConfirmationTime,
    required this.orderPayingTime,
    required this.orderShippedTime,
    required this.paidSubtitle,
    required this.shippedSubtitle,
    required this.orderId,
    required this.currencyCode,
  });
  final String numberOfRequest;
  final String totalPrice;
  final int numberOfProducts;
  final DateTime date;
  final VoidCallback onTapOnOrderDetails;
  final bool isOrderShipped;
  final bool isOrderPaied;
  final DateTime orderConfirmationTime;
  final DateTime? orderPayingTime;
  final DateTime? orderShippedTime;
  final String paidSubtitle;
  final String shippedSubtitle;
  final String orderId;
  final String currencyCode;

  @override
  State<CustomOrder> createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  @override
  void initState() {
    context.read<GetOrdersCubit>().getOrderTracking(orderId: widget.orderId);
    super.initState();
  }

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
                  color: widget.isOrderPaied ? AppColors.blueC3 : AppColors.mintGreen,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: widget.isOrderPaied ? Text(
                   S.of(context).order_is_paid,
                  style: AppStyle.styleRegular12(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ) : widget.isOrderShipped ? Text(
                   S.of(context).order_is_delivered,
                  style: AppStyle.styleRegular12(context).copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                )  : Text(
                   S.of(context).delivery_is_in_progress,
                  style: AppStyle.styleRegular12(context).copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              widget.isOrderShipped ? const SizedBox() : Text(
                 S.of(context).Will_arrive_within_days,
                style: AppStyle.styleRegular14(
                  context,
                ).copyWith(color: AppColors.gray),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          ItemsBody(
            totalPrice: widget.totalPrice,
            title: widget.date,
            numberOfProducts: widget.numberOfProducts,
            // totalPrice: "120",
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              Text(
                "${S.of(context).total}:",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 5.w),

              Text(
                widget.totalPrice,
                style: AppStyle.styleRegular18(context).copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(width: 5.w),

              Text(
                widget.currencyCode,
                style: AppStyle.styleRegular16(context).copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Row(
            children: [Expanded(child: Divider(color: AppColors.fogGray))],
          ),

          SizedBox(height: 10.h),

          // SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<GetOrdersCubit, GetOrdersState>(
                        builder: (context, state) {
                          if (state is OrderTrackingSuccess) {
                            log(state.trackingResponse.data.trackingItems.toString());
                            final trackingNumber = state
                                .trackingResponse
                                .data
                                .trackingItems.isEmpty ? "" : state
                                .trackingResponse
                                .data
                                .trackingItems[0]["tracking_number"];
                            return CustomElevatedButton(
                              backgroundColor: AppColors.primaryColor,
                              onPressed: trackingNumber == "" ? (){
                                Fluttertoast.showToast(
                                  backgroundColor: Colors.green,
                                  gravity: ToastGravity.TOP,
                                  textColor: Colors.white,
                                  msg: S.of(context).your_order_is_in_progress, );
                              } : () {
                                final extra =
                                    "https://t.17track.net/en#nums=$trackingNumber";

                                GoRouter.of(context).push(
                                  AppRouter.orderTrackingWebPage,
                                  extra: extra,
                                );
                              },
                              verticalPadding: 5.h,
                              child: Text(
                                 S.of(context).order_tracking,
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                            );
                          }
                          return CustomElevatedButton(
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              // showOrderTrackingModal(
                              //   context,
                              //   orderId: widget.orderId,
                              //   orderConfirmingTime: widget.orderConfirmationTime,
                              //   isOrderShipped: widget.isOrderShipped,
                              //   isOrderPaied: widget.isOrderPaied,
                              //   paidSubtitle: widget.paidSubtitle,
                              //   shippedSubtitle: widget.shippedSubtitle,
                              //   orderPayingTime: widget.orderPayingTime,
                              //   orderShippedTime: widget.orderShippedTime,
                              // );
                            },
                            verticalPadding: 5.h,
                            child: Text(
                               S.of(context).order_tracking,
                              style: AppStyle.styleRegular15(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomElevatedButton(
                        borderColor: AppColors.primaryColor,
                        backgroundColor: AppColors.white,
                        onPressed: widget.onTapOnOrderDetails,
                        verticalPadding: 5.h,
                        child: Text(
                           S.of(context).order_details,
                          style: AppStyle.styleRegular15(
                            context,
                          ).copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
