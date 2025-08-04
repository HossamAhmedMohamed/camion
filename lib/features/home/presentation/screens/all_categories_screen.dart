 

import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key, required this.categories});

  final List<CategoriesModel> categories;
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

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: spacing,
                  runSpacing: 25.h,
                  children: List.generate(categories.length, (index) {
                    return GestureDetector(
                      onTap: categories[index].onTap,
                      child: Container(
                        height: screenWidth > 800 ? 120.h : 80.h,
                        width: screenWidth > 800 ? 120.w : 80.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(categories[index].image!),

                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index].title,
                            style: AppStyle.styleRegular14(
                              context,
                            ).copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
