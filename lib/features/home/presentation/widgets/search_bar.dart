import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: CustomTextFormField(
                    hintText: "ابحث عن ما تريد",

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: SvgPicture.asset(
                        Assets.imagesSearchBar,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 60.w,
                      child: Row(
                        children: [
                          // // SvgPicture.asset(
                          // //   Assets.imagesFluentScanCamera,
                          // //   width: 24.w,
                          // //   height: 24.h,
                          // // ),
                          // SizedBox(
                          //   width: 24.h,
                          //   height: 24.h,
                          // ),
                          // SizedBox(width: 8.w),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async{
                              await BarcodeScanner.scan();
                            },
                            child: SvgPicture.asset(
                              Assets.imagesMdiBarcodeScan,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),

                          SizedBox(width: 8.w),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 6.w),

                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.searchFilter);
                    },
                    child: SvgPicture.asset(
                      Assets.imagesSettings,
                      width: 52.w,
                      height: 52.h,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
