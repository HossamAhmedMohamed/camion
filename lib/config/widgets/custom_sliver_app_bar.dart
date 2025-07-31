import 'package:camion/core/utils/app_images.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.leading,
    this.leadingWidth,
    this.cartImage,
    this.isShoppingCartShown,
    this.isShownDivider,
    this.isShownActions,
    this.readOnly,
    this.onSearchTap,
    this.flexibleSpace,
    this.appBarHeight,
  });

  final Widget title;
  final Widget? leading;
  final double? leadingWidth;
  final String? cartImage;
  final bool? isShoppingCartShown;
  final bool? isShownDivider;
  final bool? isShownActions;
  final bool? readOnly;
  final VoidCallback? onSearchTap;
  final Widget? flexibleSpace;
  final double? appBarHeight;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: appBarHeight ?? 150.0.h,

      floating: true,
      snap: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      actionsPadding: EdgeInsets.only(left: 12.w),

      leadingWidth: leadingWidth ?? 70.w,
      leading: leading,

      title: title,
      centerTitle: true,

      actions: isShownActions ?? true
          ? [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isShoppingCartShown ?? true
                      ? GestureDetector(
                          onTap: () {
                            final currentRoute = GoRouterState.of(
                              context,
                            ).uri.toString();
                            if (currentRoute != AppRouter.myCart) {
                              GoRouter.of(context).push(AppRouter.myCart);
                            }
                          },
                          child: SvgPicture.asset(
                            cartImage ?? Assets.imagesShoppingCart,
                            width: 30.w,
                            height: 30.h,
                          ),
                        )
                      : Container(),

                  SizedBox(width: 16.w),

                  GestureDetector(
                    onTap: () {
                      final currentRoute = GoRouterState.of(
                        context,
                      ).uri.toString();
                      if (currentRoute != AppRouter.notificationScreen) {
                        GoRouter.of(context).push(AppRouter.notificationScreen);
                      }
                    },
                    child: SvgPicture.asset(
                      Assets.imagesNotification,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                ],
              ),
            ]
          : [],

      flexibleSpace: flexibleSpace,

      bottom: isShownDivider == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ),
    );
  }
}
