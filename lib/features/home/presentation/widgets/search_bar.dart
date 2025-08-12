import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
    this.searchController,
    this.onChanged,
    this.readOnly,
    this.onTap,
  });

  final TextEditingController? searchController;
  final void Function(String)? onChanged;

  final bool? readOnly;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 6,
              child: CustomTextFormField(
                onTap: onTap,
                onChanged: onChanged,
                controller: searchController,
                hintText: "ابحث عن ما تريد",
                readOnly: readOnly,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(
                    Assets.imagesSearchBar,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 60.w,
                  child: const Row(
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
                      // const Spacer(),
                      // GestureDetector(
                      //   onTap: () async {
                      //     await BarcodeScanner.scan();
                      //   },
                      //   child: SvgPicture.asset(
                      //     Assets.imagesMdiBarcodeScan,
                      //     width: 24.w,
                      //     height: 24.h,
                      //   ),
                      // ),

                      // SizedBox(width: 8.w),
                    ],
                  ),
                ),
              ),
            ),

            // SizedBox(width: 7.w),

            // Expanded(
            //   flex: 1,
            //   child: GestureDetector(
            //     onTap: () {
            //       GoRouter.of(context).push(AppRouter.searchFilter);
            //     },
            //     child: SvgPicture.asset(
            //       Assets.imagesSettings,
            //       width: 56.w,
            //       height: 56.h,
            //     ),
            //   ),
            // ),
          ],
        ),

        SizedBox(height: 10.h),

        // Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
