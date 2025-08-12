import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmAddress extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postcodeController;
  final TextEditingController countryController;
  final TextEditingController shippingFirstNameController;
  final TextEditingController shippingLastNameController;
  final TextEditingController shippingAddress1Controller;
  final TextEditingController shippingAddress2Controller;
  final TextEditingController shippingCityController;
  final TextEditingController shippingStateController;
  final TextEditingController shippingPostcodeController;
  final TextEditingController shippingCountryController;
  final TextEditingController creditCardController;

  const ConfirmAddress({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.address1Controller,
    required this.address2Controller,
    required this.cityController,
    required this.stateController,
    required this.postcodeController,
    required this.countryController,
    required this.shippingFirstNameController,
    required this.shippingLastNameController,
    required this.shippingAddress1Controller,
    required this.shippingAddress2Controller,
    required this.shippingCityController,
    required this.shippingStateController,
    required this.shippingPostcodeController,
    required this.shippingCountryController,
    required this.creditCardController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),

            Text(
              "بياناتك",
              style: AppStyle.styleRegular16(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            _buildTextField("الاسم الأول", firstNameController),
            _buildTextField("الاسم الأخير", lastNameController),
            _buildTextField("البريد الإلكتروني", emailController),
            _buildTextField("رقم الهاتف", phoneController),
            _buildTextField("العنوان 1", address1Controller),
            _buildTextField("العنوان 2", address2Controller),
            _buildTextField("المدينة", cityController),
            _buildTextField("المحافظة", stateController),
            _buildTextField("الرمز البريدي", postcodeController),
            _buildTextField("الدولة", countryController),
            const SizedBox(height: 16),
            Text(
              "عنوان الشحن",
              style: AppStyle.styleRegular16(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            _buildTextField("الاسم الأول", shippingFirstNameController),
            _buildTextField("الاسم الأخير", shippingLastNameController),
            _buildTextField("العنوان 1", shippingAddress1Controller),
            _buildTextField("العنوان 2", shippingAddress2Controller),
            _buildTextField("المدينة", shippingCityController),
            _buildTextField("المحافظة", shippingStateController),
            _buildTextField("الرمز البريدي", shippingPostcodeController),
            _buildTextField("الدولة", shippingCountryController),
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomTextFormField(
                controller: creditCardController,
                hintText: "رقم البطاقة الائتمانية",
                keyboardType: TextInputType.number,
                maxLength: 19, // 16 رقم + 3 مسافات
                onChanged: (value) {
                  // تنسيق رقم البطاقة تلقائياً (إضافة مسافة كل 4 أرقام)
                  String newText = value.replaceAll(' ', '');
                  String formattedText = '';
              
                  for (int i = 0; i < newText.length; i++) {
                    if (i > 0 && i % 4 == 0) {
                      formattedText += ' ';
                    }
                    formattedText += newText[i];
                  }
              
                  if (formattedText != value) {
                    creditCardController.value = TextEditingValue(
                      text: formattedText,
                      selection: TextSelection.collapsed(
                        offset: formattedText.length,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              child: Text(
                "حفظ العنوان",
                style: AppStyle.styleRegular15(
                  context,
                ).copyWith(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: CustomTextFormField(controller: controller, hintText: label),
    );
  }
}
