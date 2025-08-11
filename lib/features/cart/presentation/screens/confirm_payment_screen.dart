import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_modal_bottom_sheet.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/config/widgets/expanded_row_for_user.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/models/payment_method_model.dart';
import 'package:camion/features/cart/presentation/logic/cubit/toggle_payment_cubit/payment_method_cubit.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/confirmation_products.dart';
import 'package:camion/features/cart/presentation/widgets/custom_selecting_payment_method.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/create_order_cubit/create_order_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key, required this.cartList});

  final List<GetCartModel> cartList;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const CartSliverAppBar(title: "اتمام الدفع"),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "المنتجات ",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),

                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.myCart);
                    },
                    child: Text(
                      "تعديل الطلب ",
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

          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth > 800 ? 150.h : 100.h,

              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: const ConfirmationsProductsItem(
                      imageUrl: Assets.imagesCoat,
                      productName: 'غطاء حماية للايفون 16 برو  ',
                      price: 150,
                      quantity: 5,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  ExpandedRowForUserImplementation(
                    firstTitle: "تفاصيل العنوان",
                    secondTitle: "تعديل العنوان",
                    onTapOnSecondTitle: () {
                      GoRouter.of(context).push(AppRouter.confirmAddress);
                    },
                  ),

                  SizedBox(height: 25.h),

                  Text(
                    "19 الشيخ احمد الصاوي متفرع من مكرم عبيد المنطقة السادسة , مدينة نصر . القاهرة",
                    style: AppStyle.styleRegular15(
                      context,
                    ).copyWith(color: AppColors.gray),
                  ),
                ],
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
                    "كود الخصم",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: CustomTextFormField(hintText: "كود الخصم"),
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
                                "تأكيد",
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الدفع بواسطة",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),

                  SizedBox(height: 20.h),

                  BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                    builder: (context, state) {
                      return Column(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: CustomSelectingCartDetailsMethod(
                              onTap: () {
                                context.read<PaymentMethodCubit>().changeIndex(
                                  index,
                                );
                              },
                              registerLogo: paymentMethods[index].image,
                              text: paymentMethods[index].title,
                              isSelected: state.index == index,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,

              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CustomElevatedButton(
                  verticalPadding: 4.h,
                  height: 60.h,
                  child: Text(
                    "تأكيد الدفع",
                    style: AppStyle.styleRegular15(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    context.read<CreateOrderCubit>().createOrder(
                      cartList: cartList,
                      taxPrice: "80",
                      shippingPrice: "100",
                      totalOrderPrice: "200",
                      shippingAddress: "shbeen el kom st",
                    );
                    customizeModalBottomSheet(
                      title: "لقد تم تأكيد طلبك بنجاح",
                      screenWidth: screenWidth,
                      context: context,
                      content: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                "مشاهدة الطلب",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomElevatedButton(
                              borderColor: AppColors.primaryColor,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.primaryColor,
                              child: Text(
                                "متابعة التسوق",
                                style: AppStyle.styleRegular15(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                              onPressed: () {
                                GoRouter.of(context).pushReplacement(
                                  AppRouter.selectingFromBottomNavBar,
                                );
                              },
                            ),
                          ),
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
