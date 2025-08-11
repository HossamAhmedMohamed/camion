import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
     
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                CustomSliverAppBar(
                  appBarHeight: 70.h,
                  title: Text(
                    "تفاصيل الطلب",
                    style: AppStyle.styleRegular18(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
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

                  isShoppingCartShown: false,
                  isShownActions: false,
                  isShownDivider: true,
                ),

                SliverToBoxAdapter(child: SizedBox(height: 15.h)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رقم الطلب: 548964132 ",
                          style: AppStyle.styleRegular14(
                            context,
                          ).copyWith(color: Colors.black),
                        ),

                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            Text(
                              "حالة الطلب : ",
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: Colors.black),
                            ),

                            SizedBox(width: 6.w),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mintGreen,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.imagesIconsIconamoonDeliveryLight,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "جاري التوصيل",
                                    style: AppStyle.styleRegular12(context)
                                        .copyWith(
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            Text(
                              "تاريخ الطلب: ",
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: Colors.black),
                            ),

                            Text(
                              " 15 اكتوبر 11:26 صباحا",
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: Colors.black),
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        Divider(thickness: 2.w, color: AppColors.paleGray),

                        SizedBox(height: 8.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "الطلبات",
                              style: AppStyle.styleRegular16(
                                context,
                              ).copyWith(color: AppColors.black),
                            ),

                            Text(
                              "4 عناصر",
                              style: AppStyle.styleRegular16(
                                context,
                              ).copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                SliverList.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: const CustomOrderDetails(),
                    );
                  },
                ),
              ],
            ),
          ),

          Container(
           
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
            
                        Text(
                          "\$ 50.00",
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
                          "التوصيل",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
            
                        Text(
                          "\$ 50.00",
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
                          "اجمال الكل",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
            
                        Text(
                          "\$ 50.00",
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
                      "عنوان التوصيل :",
                      style: AppStyle.styleRegular16(
                        context,
                      ).copyWith(color: AppColors.black),
                    ),
            
                    SizedBox(height: 10.h),
            
                    Text(
                      "19 الشيخ احمد الصاوي متفرع من مكرم عبيد المنطقة السادسة مدينة نصر . القاهرة",
                      style: AppStyle.styleRegular12(
                        context,
                      ).copyWith(color: AppColors.black),
                    ),
            
                    SizedBox(height: 15.h),
            
                    Text(
                      "طريقة الدفع",
                      style: AppStyle.styleRegular16(
                        context,
                      ).copyWith(color: AppColors.black),
                    ),
            
                    SizedBox(height: 10.h),
            
                    Row(
                      children: [
                        Text(
                          textDirection: TextDirection.ltr,
                          "**** **** **** 1234",
                          style: AppStyle.styleRegular16(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
            
                        SizedBox(width: 20.w),
                        SvgPicture.asset(
                          width: 25.w,
                          height: 25.h,
                          Assets.imagesIconsLogosMastercard,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
