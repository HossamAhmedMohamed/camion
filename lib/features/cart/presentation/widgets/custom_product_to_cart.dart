import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/presentation/logic/cubit/update_cubit/update_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductCartItem extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final String price;
  final int initialQuantity;
  final VoidCallback? onDelete;

  const ProductCartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    this.initialQuantity = 1,
    this.onDelete,
  });

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  late int quantity;
  late double unitPrice;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    unitPrice = double.tryParse(widget.price) ?? 0.0;
  }

  Future<void> _updateQuantity(int newQuantity) async {
    final oldQuantity = quantity;
    setState(() {
      quantity = newQuantity;
      isUpdating = true;
    });

    try {
      await context.read<UpdateCartCubit>().updateCart(
        productId: widget.productId,
        quantity: quantity,
      );
    } catch (_) {
      setState(() {
        quantity = oldQuantity;
      });
    } finally {
      setState(() {
        isUpdating = false;
      });
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
                child: CustomCachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl,
                ),
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyle.styleRegular15(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w900,
                  ),
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

          SizedBox(height: 6.h),
          Divider(thickness: 1, color: Colors.grey.shade300),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Total:',
                    style: AppStyle.styleRegular15(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    (unitPrice * quantity).toStringAsFixed(2),
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
                        if (quantity > 1) {
                          _updateQuantity(quantity - 1);
                        }
                      },
                      child: _buildQuantityButton(Icons.remove),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: isUpdating
                          ? SizedBox(
                              height: 18.sp,
                              width: 18.sp,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              quantity.toString(),
                              style: AppStyle.styleBold18(
                                context,
                              ).copyWith(color: Colors.black),
                            ),
                    ),

                    GestureDetector(
                      onTap: () => _updateQuantity(quantity + 1),
                      child: _buildQuantityButton(Icons.add),
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

  Widget _buildQuantityButton(IconData icon) {
    return Container(
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8E9E9),
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 20.sp),
    );
  }
}
