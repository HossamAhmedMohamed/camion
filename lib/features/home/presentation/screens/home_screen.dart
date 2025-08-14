import 'package:cached_network_image/cached_network_image.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/cubit/sliders_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_categories_cubit/get_categories_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/stories_cubit/stories_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_add_cart_cubit/toggle_add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle__list_or_grid_cubit/toggle_list_and_grid_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/widgets/camion_offers.dart';
import 'package:camion/features/home/presentation/widgets/categories_body.dart';
import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/home/presentation/widgets/home_join_us_now.dart';
import 'package:camion/features/home/presentation/widgets/sliver_grid_view_building.dart';
import 'package:camion/features/home/presentation/widgets/sliver_list_view_building.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final GlobalKey<HomeScreenBodyState> homeKey =
      GlobalKey<HomeScreenBodyState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit(sl<HomeRepository>())),
        BlocProvider(create: (context) => StoriesCubit(sl<HomeRepository>())),
        BlocProvider(create: (context) => AddCartCubit(sl<CartRepository>())),
        BlocProvider(create: (context) => GetCartCubit(sl<CartRepository>())),
        BlocProvider(
          create: (context) => AddToWishListCubit(sl<WishListRepository>()),
        ),

        BlocProvider(
          create: (context) => GetWishListCubit(sl<WishListRepository>()),
        ),

        BlocProvider(
          create: (context) => GetCategoriesCubit(sl<HomeRepository>()),
        ),

        BlocProvider(create: (context) => ToggleListAndGridCubit()),
        BlocProvider(create: (context) => ToggleAddCartCubit()),
        BlocProvider(create: (context) => ToggleProductIdImagesCubit()),
        BlocProvider(create: (context) => SlidersCubit(sl<HomeRepository>())),
      ],
      child: HomeScreenBody(key: homeKey),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => HomeScreenBodyState();
}

class HomeScreenBodyState extends State<HomeScreenBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();
  final pageController = PageController();

  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    context.read<StoriesCubit>().getStories();
    context.read<GetCategoriesCubit>().getCategories();
    context.read<GetWishListCubit>().getWishList();
    context.read<GetCartCubit>().getCart();
    context.read<SlidersCubit>().getSliders();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  /// refreshWishList is a function that will call getWishList
  /// on GetWishListCubit to refresh the wishlist. It is used
  /// in the home screen when the user navigates to it with
  /// extra parameter of true to refresh the wishlist.
  void refreshWishListAndCartList() {
    context.read<GetWishListCubit>().getWishList();
    context.read<GetCartCubit>().getCart();
  }

  void _onScroll() {
    final cubit = context.read<ProductsCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (cubit.hasMore && !cubit.isLoadingMore && !cubit.hasLoadMoreError) {
        cubit.getProducts(isLoadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductsCubit>().getProducts();
        context.read<GetCartCubit>().getCart();
        context.read<StoriesCubit>().getStories();
        context.read<GetCategoriesCubit>().getCategories();
        context.read<GetWishListCubit>().getWishList();
        context.read<SlidersCubit>().getSliders();
      },
      child: CustomScrollView(
        controller: _scrollController,
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

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Stories",
                style: AppStyle.styleSemiBold16(
                  context,
                ).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              child: BlocBuilder<StoriesCubit, StoriesState>(
                builder: (context, state) {
                  if (state is StoriesLoading) {
                    return ListView.builder(
                      padding: EdgeInsets.only(right: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Skeletonizer(
                            enabled: true,
                            child: Container(
                              padding: EdgeInsets.all(3.r),
                              height: 50.h,
                              width: 50.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: ClipOval(
                                  child: Image.asset(
                                    Assets.imagesIconsStoriesWatch,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is StoriesLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.only(right: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.storiesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: GestureDetector(
                            onTap: () {
                              final extra = {
                                'index': index,
                                'stories': state.storiesList,
                                'duration':
                                    state.storiesList[index].duration == 0
                                    ? 5
                                    : state.storiesList[index].duration,
                                'mediaType': state.storiesList[index].mediaType,
                              };
                              GoRouter.of(
                                context,
                              ).push(AppRouter.storiesView, extra: extra);
                            },
                            child: Container(
                              width: 70.w,
                              height: 70.w,
                              padding: EdgeInsets.all(2.r),
                              decoration: ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 3.w,
                                  ),
                                ),
                              ),
                              child:
                                  state.storiesList[index].mediaType == 'video'
                                  ? const Center(
                                      child: ClipOval(
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 60.h,

                                          imageUrl:
                                              state.storiesList[index].mediaUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Skeletonizer(
                                                enabled: true,
                                                child: Container(
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          HomeJoinUsNow(screenWidth: screenWidth),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          CategoriesBody(screenWidth: screenWidth),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // SliverToBoxAdapter(
          //   child: AspectRatio(
          //     aspectRatio: 371.w / 172.h,
          //     child: Image.asset(
          //       Assets.imagesIconsBlackfridayNotPixel,

          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: CamionOffers(pageController: pageController),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Sales",
                    style: AppStyle.styleSemiBold16(context).copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
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
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverGridViewBuilding(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    );
            },
          ),

          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              final cubit = context.read<ProductsCubit>();
              if (cubit.hasLoadMoreError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 50,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Connection Error',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().retryLoadMore();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          SliverToBoxAdapter(child: SizedBox(height: 100.h)),

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}
