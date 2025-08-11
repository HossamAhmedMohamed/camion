import 'package:camion/config/widgets/custom_list_tile.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            appBarHeight: 70.h,
            actions: const [],
            isShownDivider: true,
            title: Text(
              "الإشعارات",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 25.sp,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 25.h,
            ),
          ),

          SliverList.builder(
            itemCount: 20,

            itemBuilder: (context, index) {
              return Column(
                children: [
                  CustomListTile(
                    leading: Image.asset(Assets.imagesCamionLogo,
                    width: 30.w,
                    height: 30.h,),
                    trailing: Icon(
                      Icons.check,
                      color: AppColors.primaryColor,
                      size: 34.sp,
                    ),
                    title: "تم استلام طلبك",
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "طلبك قيد التنفيذ",
                          style: AppStyle.styleRegular14(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
                        Text(
                          "11 ساعة",
                          style: AppStyle.styleRegular12(
                            context,
                          ).copyWith(color: AppColors.gray),
                        ),
                      ],
                    ),
                  ),

                    Row(
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(
                          color: AppColors.paleGray,
                        ),
                      ))
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
