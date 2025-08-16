import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationsProductsItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  // final int quantity;
  final String price;
  final VoidCallback? onTap;

  const ConfirmationsProductsItem({
    super.key,
    required this.imageUrl,
    required this.productName,
    // required this.quantity,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            height: 60.h,
            child: CustomCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)),

          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Product Name
              Text(
                productName,
                style: AppStyle.styleRegular14(
                  context,
                ).copyWith(color: Colors.black),
              ),
              SizedBox(height: 3.h),

              // Quantity
              // Text(
              //   'الكمية: $quantity',
              //   style: AppStyle.styleRegular12(
              //     context,
              //   ).copyWith(color: AppColors.gray),
              // ),
              // SizedBox(height: 3.h),

              // Price
              // Text(
              //   '\$$price',
              //   style: AppStyle.styleBold16(
              //     context,
              //   ).copyWith(color: AppColors.primaryColor),
              // ),
            ],
          ),

          SizedBox(width: 12.w),

          // Product Image (Right side)
        ],
      ),
    );
  }
}
