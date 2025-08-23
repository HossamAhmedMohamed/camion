import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/logic/cubit/sliders_cubit/sliders_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/widgets/cursor_slider_skeleton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CamionOffers extends StatelessWidget {
  const CamionOffers({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Camion Offers",
                style: AppStyle.styleSemiBold16(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              Text(
                "",
                style: AppStyle.styleRegular14(context).copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 15.h),

        BlocBuilder<SlidersCubit, SlidersState>(
          builder: (context, state) {
            if (state is GetAllSlidersLoading) {
              return Skeletonizer(
                enabled: true,
                child: CursorSliderSkeletonizer(screenWidth: screenWidth),
              );
            }

            if (state is GetAllSlidersLoaded) {
              final sliderList = state.slidersList;
              return Column(
                children: [
                  CarouselSlider(
                    items: List.generate(state.slidersList.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: index == state.slidersList.length - 1
                              ? 15.w
                              : 0,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final url = state.slidersList[index].description;
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              Fluttertoast.showToast(
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                msg: "Could not launch $url",
                              );
                            }
                          },
                          child: SizedBox(
                            height: 162.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Stack(
                                children: [
                                  CustomCachedNetworkImage(
                                    imageUrl: state.slidersList[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),

                                  Positioned(
                                    right: 0.w,
                                    top: 10.h,
                                    child: Transform.rotate(
                                      angle: 0.4,
                                      child: Container(
                                        padding: EdgeInsets.all(10.r),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              50.r,
                                            ),
                                          ),
                                          color: AppColors.primaryColor,
                                        ),
                                        child: Transform.rotate(
                                          angle: 0,
                                          child: Text(
                                            "${state.slidersList[index].discount}% offer",
                                            style: AppStyle.styleRegular14(
                                              context,
                                            ).copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                      // height: 200.h,
                      padEnds: false,
                      aspectRatio: 350.w / 162.h,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.1,
                      onPageChanged:
                          (int index, CarouselPageChangedReason reason) =>
                              context.read<ToggleProductIdImagesCubit>().toggle(
                                index,
                              ),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  BlocBuilder<
                    ToggleProductIdImagesCubit,
                    ToggleProductIdImagesState
                  >(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(sliderList.length, (index) {
                          bool isActive = state.index == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isActive ? 38.w : 8.w,
                            height: 8.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: isActive
                                  ? AppColors.primaryColor
                                  : AppColors.paleGray,
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primaryColor.withAlpha(
                                          100,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              );
            }

            // if (state is GetAllSlidersError) {
            //   return Center(
            //     child: Text(
            //       "حدث خطأ في تحميل العروض",
            //       style: AppStyle.styleRegular14(context),
            //     ),
            //   );
            // }
            return Container();
          },
        ),
      ],
    );
  }
}
