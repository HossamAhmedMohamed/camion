import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
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
            title: Text(
              "الاقسام",
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
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Divider(
                  //     height: 1,
                  //     thickness: 1,
                  //     color: Colors.grey.shade300,
                  //   ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SearchBarHome(readOnly: false, onTap: () {}),
                  ),
                ],
              ),
            ),
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
                          GoRouter.of(context).push(
                            AppRouter.productByCategory,
                            extra: categories[index].slug,
                          );
                        },
                        // onTap: categories[index].,
                        child: Container(
                          margin: EdgeInsets.only(right: index == 0 ? 0 : 10.w),
                          child: SizedBox(
                            height: screenWidth > 800 ? 120.h : 60.h,
                            width: screenWidth > 800 ? 120.w : 60.w,
                            child: CustomCachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: categories[index].image!.thumbnail,
                            ),
                          ),
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
