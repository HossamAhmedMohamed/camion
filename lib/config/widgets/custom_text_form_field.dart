import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final Color? fieldColor;
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onTapOnSuffixIcon;
  final bool? suffixIcon;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool? readOnly;

  const CustomTextFormField({
    super.key,
    this.fieldColor,
    this.hintText,
    this.onTapOnSuffixIcon,
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
          ).copyWith(color: const Color(0xFF545454)),
          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon ?? false
              ? GestureDetector(
                  onTap: onTapOnSuffixIcon,
                  child: Container(
                    padding: EdgeInsets.all(12.h),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade700,
                      size: 24.r,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
