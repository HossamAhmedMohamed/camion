import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:camion/features/auth/presentation/widgets/custom_phone_number_controller.dart';
import 'package:camion/features/auth/presentation/widgets/phone_number_controller.dart';
import 'package:camion/generated/l10n.dart';
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
            hintText: S.of(context).full_name,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).please_enter_your_name;
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
                  hintText: S.of(context).phone_Number,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).please_enter_your_phone_number;
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
            hintText:  S.of(context).email,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return  S.of(context).please_enter_your_email;
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),

          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoaded) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green,
                  msg: S.of(context).account_created_successfully,
                );
                GoRouter.of(context).push(AppRouter.login);
              }
              if (state is RegisterError) {
                Fluttertoast.showToast(
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.red,
                  msg: state.error.message,
                );
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                child: state is RegisterLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        S.of(context).register,
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final fullPhoneNumber =
                      _phoneNumberController.fullPhoneNumber;
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
