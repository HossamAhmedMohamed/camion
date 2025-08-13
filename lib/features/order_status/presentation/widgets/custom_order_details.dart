import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/presentation/widgets/items_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrderDetails extends StatelessWidget {
  const CustomOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: getContainerBoxDecoration(),
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: screenWidth > 600 ? 120.w : 90.w,
                child: AspectRatio(
                  aspectRatio: 82.w / 86.h,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      color: AppColors.paleGray,
                    ),
                    child: Image.asset(Assets.imagesShoes, fit: BoxFit.contain),

                    // CustomCachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   imageUrl: image,
                    // ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // const ItemsBody(
              //   title: "رقم الطلب :548964132",
              //   quantity: 4,
              //   totalPrice: "120",
              // ),

              

             
            ],
          ),

          SizedBox(height: 20.h),

          const Row(
            children: [Expanded(child: Divider(color: AppColors.fogGray))],
          ),
          SizedBox(height: 20.h),
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
                    "150",
                    style: AppStyle.styleRegular18(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
