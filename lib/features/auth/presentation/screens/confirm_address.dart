import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/send_user_shipping_cubit/send_user_shipping_address_cubit.dart';
import 'package:camion/features/auth/presentation/widgets/countries_stae_cities.dart';
import 'package:camion/features/auth/presentation/widgets/custom_phone_number_controller.dart';
import 'package:camion/features/auth/presentation/widgets/phone_number_controller.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ConfirmAddress extends StatefulWidget {
  const ConfirmAddress({super.key});

  @override
  State<ConfirmAddress> createState() => _ConfirmAddressState();
}

class _ConfirmAddressState extends State<ConfirmAddress> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PhoneNumberController phoneController = PhoneNumberController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController shippingFirstNameController =
      TextEditingController();
  final TextEditingController shippingLastNameController =
      TextEditingController();
  final TextEditingController shippingEmailController = TextEditingController();
  final PhoneNumberController shippingPhoneController = PhoneNumberController();
  final TextEditingController shippingAddress1Controller =
      TextEditingController();
  final TextEditingController shippingAddress2Controller =
      TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingPostcodeController =
      TextEditingController();
  final TextEditingController shippingCountryController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    postcodeController.dispose();
    countryController.dispose();
    shippingFirstNameController.dispose();
    shippingLastNameController.dispose();
    shippingEmailController.dispose();
    shippingPhoneController.dispose();
    shippingAddress1Controller.dispose();
    shippingAddress2Controller.dispose();
    shippingCityController.dispose();
    shippingStateController.dispose();
    shippingPostcodeController.dispose();
    shippingCountryController.dispose();

    super.dispose();
  }

  String? selectedCountry;
  String? selectedCity;
  String? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            actions: const [],
            appBarHeight: 70.h,
            isShownDivider: true,
            title: Text(
              "Address Confirmation",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: Colors.black),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),
                    Text(
                      "Personal Information",
                      style: AppStyle.styleRegular16(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    CustomTextFormField(
                      hintText: "First Name",
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      hintText: "Last Name",
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: "Email",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),

                    CustomPhoneNumberField(
                      controller: phoneController,
                      hintText: "Phone number",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: "Address 1",
                      controller: address1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: "Address 2",
                      controller: address2Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),

                    CountryStateCityWidget(
                      cityController: cityController,
                      stateController: stateController,
                      countryController: countryController,
                    ),
                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      hintText: "Postcode",
                      controller: postcodeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your postcode';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Shipping Address",
                      style: AppStyle.styleRegular16(context).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const SizedBox(height: 15),

                    CustomTextFormField(
                      hintText: "First Name",
                      controller: shippingFirstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    CustomTextFormField(
                      hintText: "Last Name",
                      controller: shippingLastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      hintText: "Email",
                      controller: shippingEmailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10.h),

                    CustomPhoneNumberField(
                      controller: shippingPhoneController,
                      hintText: "Phone number",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: "Address 1",
                      controller: shippingAddress1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: "Address 2",
                      controller: shippingAddress2Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    CountryStateCityWidget(
                      cityController: shippingCityController,
                      stateController: shippingStateController,
                      countryController: shippingCountryController,
                    ),

                    // const SizedBox(height: 10),
                    const SizedBox(height: 24),

                    BlocConsumer<
                      SendUserShippingAddressCubit,
                      SendUserShippingAddressState
                    >(
                      listener: (context, state) {
                        if (state is SendUserShippingAddressError) {
                          Fluttertoast.showToast(
                            msg: state.error.message,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }

                        if (state is SendUserShippingAddressLoaded) {
                          Fluttertoast.showToast(
                            msg: "Shipping address added successfully",
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );

                          GoRouter.of(
                            context,
                          ).goNamed(AppRouter.selectingFromBottomNavBar);
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          onPressed: state is SendUserShippingAddressLoading
                              ? () {}
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  context
                                      .read<SendUserShippingAddressCubit>()
                                      .sendUserShippingAddress(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        phone: phoneController.fullPhoneNumber,
                                        address1: address1Controller.text,
                                        address2: address2Controller.text,
                                        city: cityController.text,
                                        state: stateController.text,
                                        postcode: postcodeController.text,
                                        country: countryController.text,
                                        shippingFirstName:
                                            firstNameController.text,
                                        shippingLastName:
                                            lastNameController.text,
                                        shippingEmail: emailController.text,
                                        shippingPhone: phoneController.fullPhoneNumber,
                                        shippingAddress1:
                                            address1Controller.text,
                                        shippingAddress2:
                                            address2Controller.text,
                                        shippingCity: cityController.text,
                                        shippingState: stateController.text,
                                        shippingPostcode:
                                            postcodeController.text,
                                        shippingCountry: countryController.text,
                                      );
                                },
                          child: state is SendUserShippingAddressLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Save",
                                  style: AppStyle.styleRegular15(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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
