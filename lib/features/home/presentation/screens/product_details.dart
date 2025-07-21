import 'package:camion/config/widgets/custom_expansion_tile.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/widgets/products_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,

    required this.productImages,
    required this.discountImage,
    required this.productName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.reviewCount,
    required this.sellCount,
  });

  final List<String> productImages;
  final String discountImage;
  final String productName;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final int reviewCount;
  final int sellCount;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: Text(
              "تفاصيل المنتج",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 25.sp,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemCount: widget.productImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(20.0.r),
                            child: Image.asset(
                              widget.productImages[index],
                              height: 215.h,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),

                      Positioned(
                        top: 16.h,
                        left: 16.w,
                        child: Image.asset(
                          widget.discountImage,
                          width: 60,
                          height: 60,
                        ),
                      ),

                      Positioned(
                        bottom: 16.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.productImages.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: currentIndex == index ? 20.w : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16.w,
                        bottom: 16.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            color: const Color(0xFFF0F0F0),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesBagCheck,
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(width: 5.h),
                              Text(
                                '${widget.sellCount} منتجًا مباعًا',
                                style: AppStyle.styleRegular14(
                                  context,
                                ).copyWith(color: AppColors.gray),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: 6.w,
                        bottom: 6.h,
                        child: SvgPicture.asset(
                          Assets.imagesShareProduct,

                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.productName,
                              style: AppStyle.styleBold18(context),
                            ),
                          ),
                          Image.asset(
                            Assets.imagesSave,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Text(
                            '${widget.discountedPrice.toInt()}',
                            style: AppStyle.styleBold20(
                              context,
                            ).copyWith(color: AppColors.primaryColor),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${widget.originalPrice.toInt()}',
                            style: AppStyle.styleRegular15(context).copyWith(
                              color: AppColors.gray,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.h),

                      Row(
                        children: [
                          Text(
                            '${widget.rating}',
                            style: AppStyle.styleRegular14(
                              context,
                            ).copyWith(color: Colors.grey.shade600),
                          ),

                          SizedBox(width: 5.w),
                          ...List.generate(5, (index) {
                            return Icon(
                              index < widget.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20.r,
                            );
                          }),
                        ],
                      ),

                      SizedBox(height: 5.h),

                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: AppColors.gray,
                            size: 15.r,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '32 مشاهده',
                            style: AppStyle.styleRegular10(
                              context,
                            ).copyWith(color: AppColors.gray),
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            '10 منذ ساعات',
                            style: AppStyle.styleRegular10(
                              context,
                            ).copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const ProductsSelectionOptions(),

                      SizedBox(height: 20.h),

                      const CustomExpansionTile(
                        title: "الوصف",
                        content:
                            "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      const CustomExpansionTile(
                        title: "طريقة الاستعمال",
                        content:
                            "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                      ),

                      SizedBox(
                        height: 20.h,
                      ),


                      Image.asset(Assets.imagesProductRate,
                      
                      // width: double.infinity,
                      // height: 120.h,
                      ),

                      SizedBox(height: 30.h),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'أضف للعربة',
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),

                              SizedBox(width: 6.w),

                              SvgPicture.asset(
                                Assets.imagesShoppingCartWhite,
                                width: 22.w,
                                height: 22.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}
