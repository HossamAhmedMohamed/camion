import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/presentation/logic/cubit/toggle_payment_cubit/payment_method_cubit.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/custom_selecting_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmAddress extends StatelessWidget {
  const ConfirmAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const CartSliverAppBar(title: "تغيير العنوان"),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "إضافة عنوان",
                    style: AppStyle.styleSemiBold18(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),

                  SizedBox(height: 25.h),

                  Form(
                    child: Column(
                      children: [
                        const CustomTextFormField(hintText: "اسم المدينة"),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "اسم الحي / المنطقة",
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(hintText: "اسم الشارع"),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(
                          hintText: "رقم العمارة / المنزل",
                        ),

                        SizedBox(height: 10.h),

                        const CustomTextFormField(hintText: "رقم الشقة/مكتب"),

                        SizedBox(height: 10.h),

                        BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                          builder: (context, state) {
                            final firstIndex = 0;
                            final secondIndex = 1;
                            return Row(
                              children: [
                                Expanded(
                                  child: CustomSelectingAddress(
                                    onTap: () {
                                      context
                                          .read<PaymentMethodCubit>()
                                          .changeIndex(firstIndex);
                                    },
                                    title: 'شقة',
                                    isSelected: state.index == firstIndex,
                                  ),
                                ),

                                SizedBox(width: 15.w),

                                Expanded(
                                  child: CustomSelectingAddress(
                                    onTap: () {
                                      context
                                          .read<PaymentMethodCubit>()
                                          .changeIndex(secondIndex);
                                    },
                                    title: 'مكتب',
                                    isSelected: state.index == secondIndex,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
                  padding: 4.h,
                  height: 60.h,
                  child: Text(
                    "حفظ",
                    style: AppStyle.styleRegular15(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    GoRouter.of(context).pop();
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
