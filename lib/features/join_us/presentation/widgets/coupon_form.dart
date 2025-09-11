import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/create_coupon_cubit/create_coupon_cubit.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CouponForm extends StatefulWidget {
  const CouponForm({super.key});

  @override
  State<CouponForm> createState() => _CouponFormState();
}

class _CouponFormState extends State<CouponForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  @override
  void dispose() {
    couponCodeController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: couponCodeController,
            hintText: S.of(context).coupon,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return  S.of(context).please_enter_your_coupon_code;
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: discountController,
            hintText:  S.of(context).discount_rate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return  S.of(context).please_enter_your_discount_rate;
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),

          BlocConsumer<CreateCouponCubit, CreateCouponState>(
            listener: (context, state) {
              if (state is CreateCouponSuccess) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  msg: S.of(context).Coupon_created_successfully,
                  backgroundColor: Colors.green
                );
              }
              if (state is CreateCouponError) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  msg: state.error.message,
                  backgroundColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                elevation: 0,
                textColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor.withAlpha(25),
                borderColor: AppColors.primaryColor,
                onPressed: state is CreateCouponLoading
                    ? () {}
                    : () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        } else {
                          context.read<CreateCouponCubit>().createCoupon(
                            code: couponCodeController.text,
                            discountPercentage: num.tryParse(discountController.text) ?? 0,
                          );
                        }
                      },
                child: state is CreateCouponLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                         S.of(context).create,
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
