import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/features/home/data/models/categories_model.dart';

import 'package:camion/features/home/presentation/widgets/categories_nav_bar.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:camion/features/home/presentation/widgets/sliver_grid_view_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.title, required this.leading});

  final Widget title;
  final Widget leading;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 0;

  List<CategoriesModel> categories = [
    CategoriesModel(onTap: () {}, title: "الكل"),
    CategoriesModel(onTap: () {}, title: "نساء"),
    CategoriesModel(onTap: () {}, title: "رجال"),
    CategoriesModel(onTap: () {}, title: "اطفال"),
    CategoriesModel(onTap: () {}, title: "ملابس"),
    CategoriesModel(onTap: () {}, title: "اكسسوارات"),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: widget.title, leading: widget.leading),

          const SearchBarHome(),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth > 800 ? 50.h : 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isActive = selectedIndex == index;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        categories[index].onTap();
                      },

                      child: CategoriesNavBar(
                        isActive: isActive,
                        title: categories[index].title,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 45.h)),

          SliverGridViewBuilding(screenWidth: screenWidth),

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}
