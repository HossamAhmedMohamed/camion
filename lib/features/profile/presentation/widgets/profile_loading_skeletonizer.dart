import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLoadingSkeletonizer extends StatelessWidget {
  const ProfileLoadingSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("صورتك الشخصية", style: AppStyle.styleBold16(context)),

                      // Center(
                      //   child: Image.asset(
                      //     Assets.imagesPhotoJoinUs,
                      //     height: 150.h,
                      //     width: 150.w,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      SizedBox(height: 20.h),

                      // Text(
                      //   "",
                      //   style: AppStyle.styleBold16(context),
                      // ),
                      SizedBox(height: 20.h),

                      Text(
                        "Full Name",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextFormField(
                        enabled: false,
                        initialValue: "محمد صلاح",
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        "Email",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextFormField(
                        enabled: false,
                        initialValue: "محمد صلاح",
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        "Phone Number",
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),

                      SizedBox(height: 8.h),

                      const CustomTextFormField(
                        enabled: false,
                        initialValue: "محمد صلاح",
                      ),

                      SizedBox(height: 30.h),

                      // Row(
                      //   children: [
                      //     SvgPicture.asset(Assets.imagesPlay),

                      //     SizedBox(width: 10.w),

                      //     Text(
                      //       " انت مشترك في التسويق بالعمولة",
                      //       style: AppStyle.styleRegular14(
                      //         context,
                      //       ).copyWith(color: Colors.black),
                      //     ),
                      //     SizedBox(width: 10.w),
                      //     Container(
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 10.w,
                      //         vertical: 8.h,
                      //       ),
                      //       decoration: ShapeDecoration(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12.r),
                      //         ),
                      //         color: const Color(0xFF03B603),
                      //       ),

                      //       child: Text(
                      //         "عرض نشاطك",
                      //         style: AppStyle.styleRegular14(
                      //           context,
                      //         ).copyWith(color: Colors.white),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                );
  }
}