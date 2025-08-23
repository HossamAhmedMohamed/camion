import 'dart:developer';

import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/confirmation_products.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/create_order_cubit/create_order_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({super.key, required this.cartList});

  final List<GetCartModel> cartList;

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const CartSliverAppBar(title: "Checkout"),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).pushReplacementNamed(AppRouter.myCart);
                    },
                    child: Text(
                      "View Cart",
                      style: AppStyle.styleRegular12(context).copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        decorationThickness: 1.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // 🔹 عرض المنتجات
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth > 800 ? 150.h : 100.h,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                shrinkWrap: true,
                itemCount: widget.cartList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ConfirmationsProductsItem(
                      imageUrl: widget.cartList[index].image!,
                      productName: widget.cartList[index].title!,
                      price: widget.cartList[index].price!,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coupon code",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          hintText: "Enter Coupon Code",
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: SizedBox(
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                side: const BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                "Confirm",
                                style: AppStyle.styleBold16(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
                  listener: (context, state) {
                    if (state is CreateOrderSuccess) {
                      Fluttertoast.showToast(
                        msg: state.order.message,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );

                      log(state.order.data.order.skipCashPaymentUrl);

                      GoRouter.of(context).push(
                        AppRouter.paymentWebPage,
                        extra: {
                          "checkoutUrl": state.order.data.order.skipCashPaymentUrl,
                        },
                      );
                    }
                    if (state is CreateOrderError) {
                      Fluttertoast.showToast(
                        msg: state.error.message,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                    }
                  },
                  builder: (context, state) {
                    // double total = widget.cartList.fold(
                    //   0,
                    //   (sum, item) => sum + (item.totalPrice ?? 0),
                    // );
                    return CustomElevatedButton(
                      verticalPadding: 4.h,
                      height: 60.h,
                      onPressed: state is CreateOrderLoading
                          ? () {}
                          : () {
                              context.read<CreateOrderCubit>().createOrder();
                            },
                      child: (state is CreateOrderLoading)
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              children: [
                                Text(
                                  "Checkout",
                                  style: AppStyle.styleRegular15(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),
                                // SizedBox(width: 10.w),
                                // Text(
                                //   "${total.toStringAsFixed(2)} ",
                                //   style: AppStyle.styleRegular15(
                                //     context,
                                //   ).copyWith(color: Colors.white),
                                // ),
                              ],
                            ),
                    );
                  },
                ),
              ),
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
