import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SupplierAccountScreen extends StatelessWidget {
  const SupplierAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const CustomJoinUsSliverAppBar(title: "حساب المسوق"),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: getContainerBoxDecoration(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.imagesPlay,
                      width: 25.w,
                      height: 25.h,
                    ),

                    SizedBox(width: 15.w),

                    Text(
                      "أكوادي",
                      style: AppStyle.styleRegular18(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: getContainerBoxDecoration(),
                child: Row(
                  children: [
                    Image.asset(Assets.imagesSave, width: 25.w, height: 25.h),

                    SizedBox(width: 15.w),

                    Text(
                      "إنشاء كود",
                      style: AppStyle.styleRegular18(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
