import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/data/models/order_status_item_model.dart';
import 'package:camion/features/order_status/presentation/widgets/items_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({
    super.key,
    required this.image,
    required this.title,
    required this.totalPrice,
    required this.quantity,
    required this.date,
  });

  final String image;
  final String title;
  final int totalPrice;
  final int quantity;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: getContainerBoxDecoration(),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "تم الطلب في ${DateFormat('d MMMM h:mm a', 'ar').format(date).replaceAll('ص', 'صباحاً').replaceAll('م', 'مساءً')}",
                style: AppStyle.styleRegular14(
                  context,
                ).copyWith(color: AppColors.gray),
              ),
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
            ],
          ),

          SizedBox(height: 30.h),

          Row(
            children: [
              SizedBox(
                width: screenWidth > 600 ? 120.w : 86.w,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      color: AppColors.paleGray,
                    ),
                    child: CustomCachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 15.w),

              ItemsBody(
                title: title,
                quantity: quantity,
                totalPrice: totalPrice,
              ),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [

              //     Row(
              //       children: [
              //         Text("اجمالي",
              //             style: AppStyle.styleRegular14(context).copyWith(
              //               color: AppColors.black,
              //               fontWeight: FontWeight.w500,
              //         )),
              //         SizedBox(width: 5.w),

              //         Text(
              //           "$totalPrice",
              //           style: AppStyle.styleRegular14(context).copyWith(
              //             color: AppColors.primaryColor,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     )
              //     // Row(
              //     //   children: [
              //     //     Text(
              //     //       "5.0",
              //     //       style: AppStyle.styleRegular14(context).copyWith(
              //     //         color: AppColors.black,
              //     //         fontWeight: FontWeight.w500,
              //     //       ),
              //     //     ),
              //     //     SizedBox(width: 5.w),
              //     //     Icon(Icons.star, color: AppColors.orange, size: 20.sp),
              //     //   ],
              //     // ),
              //     // Row(
              //     //   children: [
              //     //     Text(
              //     //       "3 عناصر",
              //     //       style: AppStyle.styleRegular14(
              //     //         context,
              //     //       ).copyWith(color: AppColors.gray),
              //     //     ),

              //     //     SizedBox(width: 5.w),

              //     //     Icon(
              //     //       Icons.keyboard_arrow_down,
              //     //       color: AppColors.gray,
              //     //       size: 20.sp,
              //     //     ),
              //     //   ],
              //     // ),
              //   ],
              // ),
            ],
          ),

          SizedBox(height: 20.h),

          const Row(
            children: [Expanded(child: Divider(color: AppColors.fogGray))],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "120 ج.م",
              //         style: AppStyle.styleRegular14(context).copyWith(
              //           color: AppColors.black,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       SizedBox(height: 5.h),
              //       Text(
              //         "مشاهدة",
              //         style: AppStyle.styleRegular12(
              //           context,
              //         ).copyWith(color: AppColors.gray),
              //       ),
              //       Text(
              //         "التفاصيل",
              //         style: AppStyle.styleRegular12(
              //           context,
              //         ).copyWith(color: AppColors.gray),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 15.w),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () {
                          showOrderTrackingModal(context);
                        },
                        padding: 5.h,
                        child: Text(
                          "حالة الطلب",
                          style: AppStyle.styleRegular15(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomElevatedButton(
                        borderColor: AppColors.primaryColor,
                        backgroundColor: AppColors.white,
                        onPressed: () {},
                        padding: 5.h,

                        child: Text(
                          "الغاء الطلب",
                          style: AppStyle.styleRegular15(
                            context,
                          ).copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
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
