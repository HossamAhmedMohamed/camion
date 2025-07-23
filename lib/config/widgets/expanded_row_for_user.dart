import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';

import 'package:flutter/material.dart';
 

class ExpandedRowForUserImplementation extends StatelessWidget {
  const ExpandedRowForUserImplementation({super.key, required this.firstTitle, required this.secondTitle, required this.onTapOnSecondTitle});

  final String firstTitle;
  final String secondTitle;
  final VoidCallback onTapOnSecondTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstTitle,
          style: AppStyle.styleSemiBold16(context).copyWith(color: AppColors.black),
        ),

        GestureDetector(
          onTap: onTapOnSecondTitle,
          child: Text(
             secondTitle,
            style: AppStyle.styleRegular12(context).copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
              decorationThickness: 1.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
