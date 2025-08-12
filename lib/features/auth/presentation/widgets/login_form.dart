import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:camion/features/auth/presentation/widgets/custom_phone_number_controller.dart';
import 'package:camion/features/auth/presentation/widgets/phone_number_controller.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late final PhoneNumberController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = PhoneNumberController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            hintText: "الايميل",

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الاسم';
              }
              return null;
            },
          ),

          SizedBox(height: 10.h),

          CustomPhoneNumberField(
            controller: _phoneNumberController,
            hintText: "رقم الهاتف",

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال رقم الهاتف';
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),

          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green,
                  msg: state.message);
                GoRouter.of(context).push(AppRouter.confirmPhoneNumberScreen);
              }

              if (state is LoginError) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.red,
                  msg: state.error.message);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                child: state is LoginLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "تسجيل الدخول",
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final fullPhoneNumber =
                      _phoneNumberController.fullPhoneNumber;
                  context.read<LoginCubit>().login(
                    email: _emailController.text,
                    phoneNumber: fullPhoneNumber,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
