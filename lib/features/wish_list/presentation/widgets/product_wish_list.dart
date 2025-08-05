import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';

import 'package:camion/core/utils/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductWishList extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int price;

  const ProductWishList({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  State<ProductWishList> createState() => _ProductWishListState();
}

class _ProductWishListState extends State<ProductWishList> {
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
                child: CustomCachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.imageUrl,
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
                  ],
                ),
              ),

              SizedBox(width: 25.w),

              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  Assets.imagesIconsTrashNewIcon,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          SizedBox(height: 6.h),

          Divider(thickness: 1, color: Colors.grey.shade300),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 5.w),

                  Text(
                    '${widget.price.toStringAsFixed(0)}\$',
                    style: AppStyle.styleBold18(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
