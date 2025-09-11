import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/variation.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrderDetails extends StatelessWidget {
  const CustomOrderDetails({
    super.key,
    required this.image,
    required this.title,
    required this.variations,
    required this.total,
    required this.quantity,
    required this.currency,
  });
  final String image;
  final String title;
  final List<Variation> variations;
  final String total;
  final String quantity;
  final String currency;
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
                    child: CustomCachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.contain,
                    ),

                    // CustomCachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   imageUrl: image,
                    // ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      title,
                      style: AppStyle.styleRegular14(context).copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    variations.isEmpty
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(variations.length, (index) {
                              return Padding(
                                padding:   EdgeInsets.only(bottom: index == variations.length - 1 ? 0 : 10.h),
                                child: Text(
                                  "${variations[index].attribute} : ${variations[index].value}",
                                  style: AppStyle.styleRegular14(context)
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              );
                            }),
                          ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          const Row(
            children: [Expanded(child: Divider(color: AppColors.fogGray))],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${S.of(context).total}:",
                    style: AppStyle.styleRegular16(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(width: 5.w),

                  Text(
                    total,
                    style: AppStyle.styleRegular18(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: 5.w),

                  Text(
                    currency,
                    style: AppStyle.styleRegular16(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),

              Text(
                "${S.of(context).quantity}: $quantity",
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
