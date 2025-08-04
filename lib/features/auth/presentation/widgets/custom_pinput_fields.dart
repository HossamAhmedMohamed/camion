import 'dart:developer';

import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/verify_cubit/verify_cubit.dart';
import 'package:camion/features/auth/presentation/widgets/repeating_timer_counter.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class CustomPinPutField extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const CustomPinPutField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<CustomPinPutField> createState() => _CustomPinPutFieldState();
}

class _CustomPinPutFieldState extends State<CustomPinPutField> {
  final TextEditingController _pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<String> getPhoneNumber() async {
    final phoneNumber = await sl<SecureCacheHelper>().getData(
      key: 'phoneNumber',
    );
    return phoneNumber!;
  }

  Future<String> getEmail() async {
    final email = await sl<SecureCacheHelper>().getData(key: 'email');
    return email!;
  }

  Future<Map<String, String>> getUserData() async {
    final phoneNumber = await getPhoneNumber();
    final email = await getEmail();
    return {'phoneNumber': phoneNumber, 'email': email};
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppStyle.styleSemiBold20(context),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor, width: 2.w),
      borderRadius: BorderRadius.circular(12.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1.w),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!;
          final phoneNumber = userData['phoneNumber']!;
          final email = userData['email']!;
          return Form(
            key: formKey,
            child: Column(
              children: [
                Pinput(
                  autofocus: true,
                  controller: _pinController,
                  focusNode: _focusNode,
                  length: widget.length,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  cursor: Container(
                    height: 20.h,
                    width: 1.w,
                    color: AppColors.primaryColor,
                  ),
                  onCompleted: widget.onCompleted,
                  onChanged: widget.onChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الرمز';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "اعادة الارسال بعد ",
                      style: AppStyle.styleRegular14(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),

                    SizedBox(width: 10.w),
                    RepeatingTimer(
                      code: _pinController.text,
                      phoneNumber: phoneNumber,
                      email: email,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                BlocConsumer<VerifyCubit, VerifyState>(
                  listener: (context, state) {
                    if (state is VerifyError) {
                      Fluttertoast.showToast(msg: state.error.message);
                    }

                    if (state is VerifyLoaded) {
                      GoRouter.of(
                        context,
                      ).goNamed(AppRouter.selectingFromBottomNavBar);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      child: state is VerifyLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "المتابعة",
                              style: AppStyle.styleRegular15(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                         

                        context.read<VerifyCubit>().verify(
                          code: _pinController.text,
                          phoneNumber: phoneNumber,
                          email: email,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
