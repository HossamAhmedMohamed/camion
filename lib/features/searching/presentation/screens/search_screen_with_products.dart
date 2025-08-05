import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/grid_item_skeletonizer.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreenWithProducts extends StatefulWidget {
  const SearchScreenWithProducts({super.key});

  @override
  State<SearchScreenWithProducts> createState() =>
      _SearchScreenWithProductsState();
}

class _SearchScreenWithProductsState extends State<SearchScreenWithProducts> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverAppBar(
            pinned: true,
            floating: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: CustomTextFormField(
              autoFocus: true,
              controller: _searchController,
              focusNode: _focusNode,
              hintText: 'ابحث عن ما تريد',
              onChanged: (value) {
                context.read<ProductsCubit>().searchProducts(query: value);
              },
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(Assets.imagesSearchBar),
              ),
            ),

            actions: [
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 25.sp,
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 800 ? 3 : 2,
                    childAspectRatio: (0.23.w / 0.45.h).clamp(0.5, 1),
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    return const Skeletonizer(
                      enabled: true,
                      child: GridItemBuildingSkeleton(),
                    );
                  },
                  itemCount: 20,
                );
              }

              if (state is ProductsLoaded) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 800 ? 3 : 2,
                      childAspectRatio: (0.23.w / 0.45.h).clamp(0.5, 1),
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouter.productDetails,
                            extra: product.id.toString(),
                          );
                        },
                        child: ProductCarouselWidget(
                          imageUrl: product.images[0].thumbnail,
                          productName: product.name,
                          originalPrice: product.prices.price.toString(),

                          isGridView: true,
                          onAddToCartTap: () {},
                          onAddToWishListTap: () {},
                        ),
                      );
                    },
                    itemCount: state.products.length,
                  ),
                );
              }

              if (state is ProductsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        Icon(state.error.icon, color: Colors.red, size: 50),
                        SizedBox(height: 20.h),
                        Text(
                          state.error.message,
                          style: TextStyle(fontSize: 16.sp, color: Colors.red),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
