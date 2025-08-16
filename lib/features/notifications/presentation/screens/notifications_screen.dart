import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/notifications/presentation/logic/cubit/notifications_cubit.dart';
import 'package:camion/features/notifications/presentation/widgets/notification-loading_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getNotifications();
    super.initState();
  }

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
              "Notifications",
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

          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoadingState) {
                return SliverList.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const Skeletonizer(
                      enabled: true,
                      child: NotificationLoadingSkeletonizer(),
                    );
                  },
                );
              }

              if (state is NotificationsLoadedState) {
                return SliverList.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.all(12.r),  
                      decoration: getContainerBoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                              Image.asset(
                                fit: BoxFit.cover,
                                Assets.imagesCamionLogo,
                                width: 35.w,
                                height: 35.h,
                              ),
                                              
                              SizedBox(width: 12.w),
                                              
                             
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Title
                                    Text(
                                      state.notifications[index].title,
                                      style: AppStyle.styleRegular14(
                                        context,
                                      ).copyWith(
                                          color: AppColors.black,
                                        fontWeight: FontWeight.bold),
                                    ),
                                              
                                    SizedBox(height: 4.h),
                                              
                                     
                                    Text(
                                      state.notifications[index].body,
                                      style: AppStyle.styleRegular14(
                                        context,
                                      ).copyWith(color: AppColors.black),
                                    ),
                                              
                                    // وقت الإشعار (اختياري)
                                    // Text(
                                    //   "11 ساعة",
                                    //   style: AppStyle.styleRegular12(context)
                                    //       .copyWith(color: AppColors.gray),
                                    // ),
                                  ],
                                ),
                              ),
                                              
                             
                              Icon(
                                Icons.check,
                                color: AppColors.primaryColor,
                                size: 34.sp,
                              ),
                            ],
                          ),

                          
                        ],
                      ),
                    );
                  },
                );
              }

              if (state is NotificationsErrorState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(state.error.icon, color: Colors.red, size: 50),

                        SizedBox(height: 20.h),
                        Text(
                          state.error.message,
                          style: TextStyle(fontSize: 16.sp, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 10.h),

                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<NotificationsCubit>()
                                .getNotifications();
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(child: Container());
            },
          ),
        ],
      ),
    );
  }
}
