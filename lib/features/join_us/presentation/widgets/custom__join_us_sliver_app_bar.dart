import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomJoinUsSliverAppBar extends StatelessWidget {
  const CustomJoinUsSliverAppBar({
    super.key, required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      appBarHeight: 70.h,
      actions: const [],
      title: Text(
        title,
        style: AppStyle.styleRegular18(context).copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    
      leading: GestureDetector(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.black,
          size: 25.r,
        ),
      ),
      isShoppingCartShown: false,
      isShownActions: false,
    );
  }
}
