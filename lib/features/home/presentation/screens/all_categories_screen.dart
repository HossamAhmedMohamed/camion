import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key, required this.categories});

  final List<GeTCategoriesModel> categories;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 25.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            actions: const [],
            title: Text(
              "Categories",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 25,
              ),
            ),
            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: true,
            //   background: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       // Divider(
            //       //     height: 1,
            //       //     thickness: 1,
            //       //     color: Colors.grey.shade300,
            //       //   ),
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.w),
            //         child: SearchBarHome(readOnly: false, onTap: () {}),
            //       ),
            //     ],
            //   ),
            // ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double availableWidth = constraints.maxWidth;

                double itemMinWidth = 100;
                double spacing = 10.w;

                int itemsPerRow =
                    ((availableWidth + spacing) / (itemMinWidth + spacing))
                        .floor();
                itemsPerRow = itemsPerRow.clamp(2, 6);

                // double itemWidth =
                //     (availableWidth - (spacing * (itemsPerRow - 1))) /
                //     itemsPerRow;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: spacing,
                    runSpacing: 25.h,
                    children: List.generate(categories.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          final slug = categories[index].name;
                          final id = categories[index].id;
                          GoRouter.of(context).push(
                            AppRouter.productByCategory,
                            extra: {"slug": slug, "id": id},
                          );
                        },
                        // onTap: categories[index].,
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth > 800 ? 140.w : 80.w,
                              height: screenWidth > 800 ? 140.h : 80.h,
                              padding: EdgeInsets.all(0.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(15),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2.h),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(left: 15.w),
                              // margin: EdgeInsets.only(right: index == 0 ? 0 : 10.w),
                              child: SizedBox(
                                height: screenWidth > 800 ? 120.h : 60.h,
                                width: screenWidth > 800 ? 120.w : 60.w,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: ClipOval(
                                        child: CustomCachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: categories[index]
                                              .image!
                                              .thumbnail,
                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   top: 10.h,
                                    //   bottom: 10.h,
                                    //   left: 20.w,
                                    //   right: 20.w,
                                    //   child: Center(
                                    //     child: FittedBox(
                                    //       child: Text(
                                    //         categories[index].name,
                                    //         style: AppStyle.styleRegular18(
                                    //           context,
                                    //         ).copyWith(
                                    //           color: Colors.black),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 5.h),

                            Text(
                              textAlign: TextAlign.center,
                              categories[index].name,
                              style: AppStyle.styleRegular12(
                                context,
                              ).copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
