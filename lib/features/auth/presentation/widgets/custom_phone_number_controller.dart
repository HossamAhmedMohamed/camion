// widgets/custom_phone_number_field.dart
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/countries_dropdown_button.dart';
import 'package:camion/features/auth/presentation/widgets/phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhoneNumberField extends StatefulWidget {
  final PhoneNumberController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final VoidCallback? onTap;

  const CustomPhoneNumberField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.onTap,
  });

  @override
  State<CustomPhoneNumberField> createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CountryPickerBottomSheet(
        selectedCountry: widget.controller.selectedCountry,
        onCountrySelected: (country) {
          widget.controller.setCountry(country);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller.phoneController,
      keyboardType: TextInputType.phone,
      enabled: widget.enabled,
      onTap: widget.onTap,
      style: AppStyle.styleRegular15(context).copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget.hintText,
        // hintStyle: AppStyle.styleRegular15(context).copyWith(
        //   color:   AppColors.gray,
        // ),
        suffixIcon: InkWell(
          onTap: widget.enabled ? _showCountryPicker : null,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.controller.selectedCountry.flag,
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(width: 8.w),
                Text(
                  widget.controller.selectedCountry.dialCode,
                  style: AppStyle.styleSemiBold15(context),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red, width: 2.w),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      validator: widget.validator,
    );
  }
}