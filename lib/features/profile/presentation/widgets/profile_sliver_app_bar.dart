import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 

class ProfileSliverAppBar extends StatelessWidget {
  const ProfileSliverAppBar({super.key, required this.title, required this.isShoppingCartShown, required this.leading});

  final Widget title;
  final Widget leading;
  final bool isShoppingCartShown;
  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      appBarHeight: 70.h,
      title: title,
      leadingWidth: 50.w,
      leading: leading,
      isShoppingCartShown: isShoppingCartShown,
      isShownDivider: true,
      isShownActions: false,
      actions: const [],
    );
  }
}
