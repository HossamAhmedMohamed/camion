import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration getContainerBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 2.h),
        ),
      ],
    );
  }