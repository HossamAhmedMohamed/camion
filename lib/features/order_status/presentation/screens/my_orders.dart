import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/toggle_nav_bar/toggle_nav_bar_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order.dart';
import 'package:camion/features/order_status/presentation/widgets/status_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static List<CategoriesModel> categories = [
    CategoriesModel(onTap: () {}, title: "الكل"),
    CategoriesModel(onTap: () {}, title: "قيد التنفيذ"),
    CategoriesModel(onTap: () {}, title: "المكتملة"),
    CategoriesModel(onTap: () {}, title: "الملغية"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              "طلباتي",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),

            isShoppingCartShown: false,
            isShownActions: false,
            isShownDivider: true,
          ),

          SliverToBoxAdapter(child: SizedBox(height: 25.h)),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),

              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                color: AppColors.lightGray,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  categories.length,
                  (index) =>
                      BlocSelector<ToggleNavBarCubit, ToggleNavBarState, bool>(
                        selector: (state) {
                          return state.index == index;
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ToggleNavBarCubit>().toggle(index);
                            },

                            child: StatusNavBar(
                              isActive: state,
                              title: categories[index].title,
                            ),
                          );
                        },
                      ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: const CustomOrder(),
              );
            },
          ),

          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}
