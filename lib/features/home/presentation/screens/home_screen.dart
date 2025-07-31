import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_cubit/toggle_list_and_grid_cubit.dart';
import 'package:camion/features/home/presentation/widgets/categories_text.dart';
import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/home/presentation/widgets/home_join_us_now.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:camion/features/home/presentation/widgets/sliver_grid_view_building.dart';
import 'package:camion/features/home/presentation/widgets/sliver_list_view_building.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit(sl<HomeRepository>())),
        BlocProvider(create: (context) => ToggleListAndGridCubit()),
      ],
      child: const HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static const List<String> stories = [
    Assets.imagesNehal,
    Assets.imagesNada,
    Assets.imagesMohamed,
    Assets.imagesMona,
    Assets.imagesMariem,
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        HomeSliverAppBar(
          onSearchTap: () {
            context.push(AppRouter.searchScreenWithProducts);
          },
          readOnly: true,
        ),

        // SearchBarHome(
        //   searchController: searchController,
        //   onChanged: (value) {
        //     context.read<ProductsCubit>().searchProducts(query: value);
        //   },
        // ),
        SliverToBoxAdapter(child: SizedBox(height: 8.h)),
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 100.h,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: stories.length,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: EdgeInsets.only(right: 10.w),
        //           child: Image.asset(stories[index]),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        HomeJoinUsNow(screenWidth: screenWidth),

        SliverToBoxAdapter(child: SizedBox(height: 10.h)),

        CategoriesBody(screenWidth: screenWidth),

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

        SliverToBoxAdapter(
          child: Image.asset(
            Assets.imagesBlackFriday,
            height: 180.h,
            fit: BoxFit.fill,
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الاكثر مشاهدة",
                  style: AppStyle.styleSemiBold18(
                    context,
                  ).copyWith(color: AppColors.black),
                ),

                BlocBuilder<ToggleListAndGridCubit, ToggleListAndGridState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        // View toggle icons
                        GestureDetector(
                          onTap: () {
                            context.read<ToggleListAndGridCubit>().toggleView(
                              true,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: state.isListView
                                  ? AppColors.primaryColor.withAlpha(25)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.view_list_rounded,
                              color: state.isListView
                                  ? AppColors.primaryColor
                                  : AppColors.gray,
                              size: 24.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            context.read<ToggleListAndGridCubit>().toggleView(
                              false,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: !state.isListView
                                  ? AppColors.primaryColor.withAlpha(25)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.grid_view_rounded,
                              color: !state.isListView
                                  ? AppColors.primaryColor
                                  : AppColors.gray,
                              size: 24.w,
                            ),
                          ),
                        ),
                        // SizedBox(width: 10.w),

                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Text(
                        //     "المزيد",
                        //     style: AppStyle.styleRegular14(context).copyWith(
                        //       color: AppColors.primaryColor,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 15.h)),

        BlocBuilder<ToggleListAndGridCubit, ToggleListAndGridState>(
          builder: (context, state) {
            return state.isListView
                ? const SliverListViewBuilding()
                : SliverGridViewBuilding(screenWidth: screenWidth);
          },
        ),

        SliverToBoxAdapter(child: SizedBox(height: 100.h)),

        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ),
      ],
    );
  }
}
