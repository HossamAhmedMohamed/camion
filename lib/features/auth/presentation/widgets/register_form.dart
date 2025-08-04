import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:camion/features/auth/presentation/widgets/custom_phone_number_controller.dart';
import 'package:camion/features/auth/presentation/widgets/phone_number_controller.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  late final PhoneNumberController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = PhoneNumberController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _fullNameController,
            hintText: "الاسم هنا",

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الاسم';
              }
              return null;
            },
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomPhoneNumberField(
                  controller: _phoneNumberController,
                  hintText: "رقم الهاتف",

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال  رقم الهاتف';
                    }
                    if (value.length < 8) {
                      return 'رقم الهاتف قصير جداً';
                    }
                    return null;
                  },
                ),
              ),

              // Expanded(child: Image.asset(Assets.imagesFlag)),
            ],
          ),

          SizedBox(height: 10.h),

          CustomTextFormField(
            controller: _emailController,
            hintText: "البريد الإلكتروني",

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال البريد الإلكتروني';
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),

          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoaded) {
                GoRouter.of(context).push(AppRouter.login);
              }
              if (state is RegisterError) {
                Fluttertoast.showToast(msg: state.error.message);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                child: state is RegisterLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "إنشاء حساب",
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final fullPhoneNumber = _phoneNumberController.fullPhoneNumber;
                  context.read<RegisterCubit>().register(
                    fullName: _fullNameController.text,
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
