import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Widget? widget;
  final double? elevation;
  final double? height;
  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.widget,
    this.elevation,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFFB92123),
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 16.h,
            horizontal: horizontalPadding ?? 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          side: borderColor == null
              ? null
              : BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 1.5,
                ),
          elevation: elevation ?? 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? Container(),

            widget != null ? SizedBox(width: 8.w) : Container(),
            child,
          ],
        ),
      ),
    );
  }
}
