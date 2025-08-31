import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order_details.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.items,
    required this.numberOfOrder,
    required this.orderDate,
    required this.totalPrice,
    required this.deliveryCost,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.currency,
  });

  final List<OrderItemModel> items;
  final String numberOfOrder;
  final DateTime orderDate;
  final String totalPrice;
  final String currency;
  final String deliveryCost;
  final String paymentMethod;
  final String shippingAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            actions: const [],
            title: Text(
              "Order Details",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),

            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 24.sp,
              ),
            ),

            isShownDivider: true,
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order Number:",
                        style: AppStyle.styleRegular18(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10.w),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                numberOfOrder,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.styleRegular14(
                                  context,
                                ).copyWith(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.copy,
                                size: 18,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: numberOfOrder),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 10.h),

                  // Row(
                  //   children: [
                  //     Text(
                  //       "حالة الطلب : ",
                  //       style: AppStyle.styleRegular14(
                  //         context,
                  //       ).copyWith(color: Colors.black),
                  //     ),

                  //     SizedBox(width: 6.w),

                  //     Container(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 6.w,
                  //         vertical: 3.h,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: AppColors.mintGreen,
                  //         borderRadius: BorderRadius.circular(10.r),
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           SvgPicture.asset(
                  //             Assets.imagesIconsIconamoonDeliveryLight,
                  //           ),
                  //           SizedBox(width: 6.w),
                  //           Text(
                  //             "جاري التوصيل",
                  //             style: AppStyle.styleRegular12(context)
                  //                 .copyWith(
                  //                   color: AppColors.green,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        "Order Date:",
                        style: AppStyle.styleRegular18(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10.w),

                      Text(
                        DateFormat('d MMMM h:mm a', 'en')
                            .format(orderDate)
                            .replaceAll('ص', 'صباحاً')
                            .replaceAll('م', 'مساءً'),
                        style: AppStyle.styleRegular14(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  // Divider(thickness: 2.w, color: AppColors.paleGray),

                  // SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Orders",
                        style: AppStyle.styleRegular18(context).copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                      ),

                      Text(
                        items.length.toString(),
                        style: AppStyle.styleRegular18(context).copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.productDetails,
                      extra: items[index].productId,
                    );
                  },
                  child: CustomOrderDetails(
                    currency: currency,
                    image: items[index].image,
                    title: items[index].title,
                    variations: items[index].variation,
                    total: items[index].price,
                    quantity: items[index].quantity.toString(),
                  ),
                ),
              );
            },
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),

                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(16.r),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Details",
                        style: AppStyle.styleRegular18(
                          context,
                        ).copyWith(color: AppColors.black),
                      ),

                      SizedBox(height: 14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            "${(double.parse(totalPrice)).toStringAsFixed(2)} $currency",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Charge",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            "$deliveryCost $currency",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            "${(double.parse(totalPrice) + double.parse(deliveryCost)).toStringAsFixed(2)} $currency",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      Divider(thickness: 2.w, color: AppColors.paleGray),

                      SizedBox(height: 10.h),

                      Text(
                        "Delivery Address",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        shippingAddress,
                        style: AppStyle.styleRegular12(
                          context,
                        ).copyWith(color: AppColors.black),
                      ),

                      SizedBox(height: 18.h),

                      Row(
                        children: [
                          Text(
                            "Payment Method",
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.primaryColor),
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            paymentMethod,
                            style: AppStyle.styleRegular16(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),
                        ],
                      ),

                      // SizedBox(height: 10.h),

                      // Row(
                      //   children: [
                      //     Text(
                      //       textDirection: TextDirection.ltr,
                      //       "**** **** **** 1234",
                      //       style: AppStyle.styleRegular16(
                      //         context,
                      //       ).copyWith(color: AppColors.black),
                      //     ),

                      //     SizedBox(width: 20.w),
                      //     SvgPicture.asset(
                      //       width: 25.w,
                      //       height: 25.h,
                      //       Assets.imagesIconsLogosMastercard,
                      //     ),
                      //   ],
                      // ),
                    ],
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
