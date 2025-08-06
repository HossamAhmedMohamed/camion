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
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final OutlineInputBorder? focusedBorder;
  final bool? enabled;
  final String? initialValue;

  const CustomTextFormField({
    super.key,
    this.fieldColor,
    this.hintText,
    this.focusNode,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.readOnly,
    this.onChanged,
    this.prefixIcon,
    this.maxLength,
    this.maxLines,
    this.onTap,
    this.autoFocus,
    this.focusedBorder,
    this.enabled,
    this.initialValue,
  
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      
      enabled: enabled,
      autofocus: autoFocus ?? false,
      onChanged: onChanged,
      style: AppStyle.styleRegular15(context).copyWith(color: AppColors.black),
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: fieldColor != null,
        fillColor: fieldColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
        ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
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
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
