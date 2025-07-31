import 'package:camion/features/home/presentation/logic/cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/widgets/custom_product.dart';
import 'package:camion/features/home/presentation/widgets/list_view_item_skeletonizer.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverListViewBuilding extends StatelessWidget {
  const SliverListViewBuilding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return SliverList.builder(
            itemBuilder: (context, index) {
             
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const Skeletonizer(
                  enabled: true,
                  child: ListViewItemBuildingSkeleton()),
              );
            },
            itemCount: 20,
          );
        }

        if (state is ProductsLoaded) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).push(AppRouter.productDetails, extra: product);
                  },
                  child: ProductCarouselWidget(
                    imageUrl: product.picUrl,
                    productName: product.productName,
                    originalPrice: product.price.price.toInt(),
                    sellCount: product.sellCount,
                    isGridView: false,
                  ),
                ),
              );
            },
            itemCount: state.products.length,
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

                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductsCubit>().retryLoadMore();
                    },
                    child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
