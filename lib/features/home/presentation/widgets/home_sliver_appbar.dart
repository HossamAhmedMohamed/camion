import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
    this.isShownDivider,
    this.onSearchTap,
    this.readOnly,
  });

  final bool? isShownDivider;
  final VoidCallback? onSearchTap;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return CustomSliverAppBar(
      readOnly: readOnly,
      onSearchTap: onSearchTap,
      title: Image.asset(Assets.imagesCamionLogo, width: 65.w, height: 50.h),
      leading: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(AppRouter.help);
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SvgPicture.asset(Assets.imagesIconsCustomerService),
        ),
      ),
      isShownDivider: isShownDivider,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Divider(
            //     height: 1,
            //     thickness: 1,
            //     color: Colors.grey.shade300,
            //   ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SearchBarHome(readOnly: readOnly, onTap: onSearchTap),
            ),
          ],
        ),
      ),
    );
  }
}
