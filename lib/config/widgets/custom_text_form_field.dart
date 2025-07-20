import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final Color? fieldColor;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool? readOnly;

  const CustomTextFormField({
    super.key,
    this.fieldColor,
    this.hintText,

    this.suffixIcon,
    this.validator,
    this.controller,
    this.readOnly,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: fieldColor ?? Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.styleRegular14(
            context,
          ).copyWith(color: AppColors.gray),
          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
