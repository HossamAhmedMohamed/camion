import 'package:camion/config/localization/cubit/localizations_cubit.dart';
import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_categories_cubit/get_categories_cubit.dart';
import 'package:camion/generated/l10n.dart';
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
                  S.of(context).categories,
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
                    S.of(context).view_all,
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
                    final categoriesWithImages = state.categories
                        .where(
                          (category) =>
                              category.image != null &&
                              category.image!.thumbnail.isNotEmpty,
                        )
                        .toList();

                    if (categoriesWithImages.isEmpty) {
                      return Container();
                    }

                    categories = categoriesWithImages;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(categoriesWithImages.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                final slug = categoriesWithImages[index].name;
                                final id = categoriesWithImages[index].id;
                                GoRouter.of(context).push(
                                  AppRouter.productByCategory,
                                  extra: {"slug": slug, "id": id},
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: widget.screenWidth > 800
                                        ? 140.w
                                        : 80.w,
                                    height: widget.screenWidth > 800
                                        ? 140.h
                                        : 80.h,
                                    padding: EdgeInsets.all(0.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(15),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 2.h),
                                        ),
                                      ],
                                    ),
                                    margin:
                                        context
                                                .watch<LocalizationsCubit>()
                                                .state
                                                .languageCode ==
                                            'ar'
                                        ? EdgeInsets.only(right: 15.w)
                                        : EdgeInsets.only(left: 15.w),
                                    child: SizedBox(
                                      height: widget.screenWidth > 800
                                          ? 120.h
                                          : 60.h,
                                      width: widget.screenWidth > 800
                                          ? 120.w
                                          : 60.w,
                                      child: Center(
                                        child: ClipOval(
                                          child: CustomCachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                categoriesWithImages[index]
                                                    .image!
                                                    .thumbnail,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 5.h),

                                  Padding(
                                    padding:
                                        context
                                                .watch<LocalizationsCubit>()
                                                .state
                                                .languageCode ==
                                            'ar'
                                        ? EdgeInsets.only(right: 15.w)
                                        : EdgeInsets.only(left: 15.w),
                                    child: SizedBox(
                                      width: widget.screenWidth > 800
                                          ? 140.w
                                          : 80.w,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          categoriesWithImages[index].name,
                                          style: AppStyle.styleRegular12(
                                            context,
                                          ).copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 6.h),
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
                              context.read<GetCategoriesCubit>().getCategories(
                                lang: context
                                    .read<LocalizationsCubit>()
                                    .state
                                    .languageCode,
                              );
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
