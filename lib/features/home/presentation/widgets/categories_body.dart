import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_categories_cubit/get_categories_cubit.dart';
import 'package:camion/routing/app_router.dart' show AppRouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesBody extends StatefulWidget {
  const CategoriesBody({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  // VoidCallback onCategoreyTap(BuildContext context, {required String title}) {
  @override
  Widget build(BuildContext context) {
    // List<CategoriesModel> firstCategories = [
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاطفال"),
    //     title: "الاطفال",
    //     image: Assets.imagesChildren,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاثاث"),
    //     title: "الأثاث",
    //     image: Assets.imagesFurniture,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الموضة"),
    //     title: "الموضة",
    //     image: Assets.imagesClothes,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "المطبخ"),
    //     title: "المطبخ",
    //     image: Assets.imagesKithcen,
    //   ),

    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاطفال"),
    //     title: "الاطفال",
    //     image: Assets.imagesChildren,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاثاث"),
    //     title: "الأثاث",
    //     image: Assets.imagesFurniture,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الموضة"),
    //     title: "الموضة",
    //     image: Assets.imagesClothes,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "المطبخ"),
    //     title: "المطبخ",
    //     image: Assets.imagesKithcen,
    //   ),

    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاطفال"),
    //     title: "الاطفال",
    //     image: Assets.imagesChildren,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاثاث"),
    //     title: "الأثاث",
    //     image: Assets.imagesFurniture,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الموضة"),
    //     title: "الموضة",
    //     image: Assets.imagesClothes,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "المطبخ"),
    //     title: "المطبخ",
    //     image: Assets.imagesKithcen,
    //   ),
    // ];

    // List<CategoriesModel> secondCategories = [
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "البيت"),
    //     title: "البيت",
    //     image: Assets.imagesHomeCategory,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاجهزة"),
    //     title: "الاجهزة",
    //     image: Assets.imagesDevices,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "المطبخ"),
    //     title: "المطبخ",
    //     image: Assets.imagesKithcen,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الموبايل"),
    //     title: "الموبايل",
    //     image: Assets.imagesMobile,
    //   ),

    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "البيت"),
    //     title: "البيت",
    //     image: Assets.imagesHomeCategory,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الاجهزة"),
    //     title: "الاجهزة",
    //     image: Assets.imagesDevices,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "المطبخ"),
    //     title: "المطبخ",
    //     image: Assets.imagesKithcen,
    //   ),
    //   CategoriesModel(
    //     onTap: onCategoreyTap(context, title: "الموبايل"),
    //     title: "الموبايل",
    //     image: Assets.imagesMobile,
    //   ),
    // ];

    List<GeTCategoriesModel> categories = [];

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الاقسام",
                  style: AppStyle.styleSemiBold16(context).copyWith(
                    color: AppColors.black,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    final extra = categories;
                    if (extra.isEmpty) {
                      return;
                    }
                    GoRouter.of(
                      context,
                    ).push(AppRouter.allCategoriesScreen, extra: extra);
                  },

                  child: Text(
                    "عرض الكل",
                    style: AppStyle.styleRegular14(context).copyWith(
                      color: AppColors.primaryColor,

                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                builder: (context, state) {
                  if (state is GetCategoriesLoading) {
                    return Row(
                      children: List.generate(6, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: index == 0 ? 0 : 10.w),
                          child: Skeletonizer(
                            enabled: true,
                            child: SizedBox(
                              height: widget.screenWidth > 800 ? 120.h : 60.h,
                              width: widget.screenWidth > 800 ? 120.w : 60.w,
                              child: Image.asset(Assets.imagesShoes),
                            ),
                          ),
                        );
                      }),
                    );
                  }
                  if (state is GetCategoriesSuccess) {
                    categories = state.categories;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(state.categories.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                final extra = state.categories[index].slug;
                                GoRouter.of(context).push(
                                  AppRouter.productByCategory,
                                  extra: extra,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: index == 0 ? 0 : 10.w,
                                ),
                                child: SizedBox(
                                  height: widget.screenWidth > 800
                                      ? 120.h
                                      : 60.h,
                                  width: widget.screenWidth > 800
                                      ? 120.w
                                      : 60.w,
                                  child: CustomCachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: state
                                        .categories[index]
                                        .image!
                                        .thumbnail,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 15.h),
                      ],
                    );
                  }
                  if (state is GetCategoriesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(state.error.icon, color: Colors.red, size: 50),

                          SizedBox(height: 20.h),
                          Text(
                            state.error.message,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 10.h),

                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<GetCategoriesCubit>()
                                  .getCategories();
                            },
                            child: Text(
                              'Retry',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
