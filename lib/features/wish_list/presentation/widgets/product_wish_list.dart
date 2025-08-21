import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductWishList extends StatefulWidget {
  final VoidCallback removeFromWishList;
  final String imageUrl;
  final String title;
  final String price;
  final bool isSelected;
  final bool isSelectionMode;
  final ValueChanged<bool> onSelectionChanged;

  const ProductWishList({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.removeFromWishList,
    this.isSelected = false,
    this.isSelectionMode = false,
    required this.onSelectionChanged,
  });

  @override
  State<ProductWishList> createState() => _ProductWishListState();
}

class _ProductWishListState extends State<ProductWishList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProductWishList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isSelected ? _scaleAnimation.value : 1.0,
          child: Container(
            margin: EdgeInsets.only(bottom: 14.h, left: 16.w, right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: widget.isSelected
                  ? Border.all(color: AppColors.primaryColor, width: 2.5)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: widget.isSelected
                      ? AppColors.primaryColor.withAlpha(15)
                      : Colors.black.withAlpha(15),
                  spreadRadius: widget.isSelected ? 3 : 2,
                  blurRadius: widget.isSelected ? 8 : 4,
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
                    // Checkbox للتحديد المتعدد
                    if (widget.isSelectionMode) ...[
                      Container(
                        width: 30.w,
                        height: 30.h,
                        margin: EdgeInsets.only(right: 8.w, top: 5.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isSelected
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: widget.isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: widget.isSelected
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18.sp,
                              )
                            : null,
                      ),
                    ],

                    Stack(
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

                        // Overlay للتحديد
                        if (widget.isSelected)
                          Positioned.fill(
                            child: Container(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                color: AppColors.primaryColor.withAlpha(50),
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          ),
                      ],
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
                              color: widget.isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          if (widget.isSelected)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.primaryColor.withAlpha(50),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: AppColors.primaryColor,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Selected',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10.w),

                    if (!widget.isSelectionMode)
                      InkWell(
                        onTap: widget.removeFromWishList,
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          child: SvgPicture.asset(
                            Assets.imagesIconsNewwwActiveHeart,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ),
                      ),

                    if (widget.isSelectionMode && widget.isSelected)
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.share,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 8.h),
                SizedBox(height: 6.h),

                // خط فاصل مع لون ديناميكي
                Divider(
                  thickness: 1,
                  color: widget.isSelected
                      ? AppColors.primaryColor.withAlpha(50)
                      : Colors.grey.shade300,
                ),

                // السعر مع تأثيرات بصرية
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 5.w),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: widget.isSelected
                              ? EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                )
                              : EdgeInsets.zero,
                          decoration: widget.isSelected
                              ? BoxDecoration(
                                  color: AppColors.primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(8.r),
                                )
                              : null,
                          child: Text(
                            '${widget.price}\$',
                            style: AppStyle.styleBold18(context).copyWith(
                              color: widget.isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor,
                              fontSize: widget.isSelected ? 20.sp : 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // مؤشر التحديد الإضافي
                    if (widget.isSelected)
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
