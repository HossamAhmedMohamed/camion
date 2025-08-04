import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';

import 'package:camion/core/utils/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductCartItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int initialQuantity;
  final VoidCallback? onDelete;
  final Function(int)? onQuantityChanged;

  const ProductCartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    this.initialQuantity = 1,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
    if (widget.onQuantityChanged != null) {
      widget.onQuantityChanged!(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 14.h, left: 16.w, right: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth > 600 ? 120.w : 86.w,
                height: screenWidth > 600 ? 120.h : 86.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  color: AppColors.paleGray,
                ),
                child: Image.asset(
                  widget.imageUrl,
                  // width: screenWidth > 600 ? 120.w : 80.w,
                  // height: screenWidth > 600 ? 120.h : 80.h,
                  // fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppStyle.styleRegular15(context).copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        SvgPicture.asset(
                          width: 21.w,
                          height: 21.h,
                          Assets.imagesIconsIconamoonDeliveryLight,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            widget.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppStyle.styleRegular14(context).copyWith(
                              color: const Color(0xFF008000),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 25.w),

              InkWell(
                onTap: widget.onDelete,
                child: SvgPicture.asset(
                  Assets.imagesIconsTrashNewIcon,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // SizedBox(height: 16.h),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'احصل على 52% توفير على التوصيل بدلاً',
          //       style: AppStyle.styleRegular12(
          //         context,
          //       ).copyWith(color: AppColors.black),
          //     ),

          //     InkWell(
          //       onTap: () {},
          //       child: Text(
          //         'اضف عنصر',
          //         style: AppStyle.styleBold12(context).copyWith(
          //           color: AppColors.primaryColor,
          //           decoration: TextDecoration.underline,
          //           decorationColor: AppColors.primaryColor,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // SizedBox(height: 6.h),
          // Image.asset(Assets.imagesDelivery),

          // SizedBox(height: 16.h),
          SizedBox(height: 6.h),

          Divider(thickness: 1, color: Colors.grey.shade300),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'اجمالي:',
                    style: AppStyle.styleRegular15(context)
                        .copyWith(color: Colors.black)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),

                  SizedBox(width: 5.w),

                  Text(
                    '${widget.price.toStringAsFixed(0)}\$',
                    style: AppStyle.styleBold18(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(
                      color: AppColors.primaryColor.withAlpha(40),
                      width: 1.5.w,
                    ),
                  ),
                  color: AppColors.primaryColor.withAlpha(15),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _updateQuantity(quantity + 1);
                      },
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8E9E9),
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Icon(Icons.add, size: 20.sp),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: AppStyle.styleBold18(
                            context,
                          ).copyWith(color: Colors.black),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          _updateQuantity(quantity - 1);
                        }
                      },
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8E9E9),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Icon(Icons.remove, size: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // SizedBox(height: 16.h),

          // CustomElevatedButton(
          //   text: "المتابعة للدفع",
          //   onPressed: () {
          //     GoRouter.of(context).push(AppRouter.confirmPayment);
          //   },
          // ),
        ],
      ),
    );
  }
}
