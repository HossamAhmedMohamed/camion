import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCodingsScreen extends StatelessWidget {
  const MyCodingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const CustomJoinUsSliverAppBar(title: "أكوادي"),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverList.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mariam12",
                          style: AppStyle.styleRegular18(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),

                        Text(
                          "5%",
                          style: AppStyle.styleRegular18(
                            context,
                          ).copyWith(color: AppColors.gray),
                        ),
                      ],
                    ),

                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.lightGray,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
