import 'package:camion/config/widgets/custom_sliver_app_bar.dart';

import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/wish_list/data/models/get_wish_list_model.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/widgets/product_wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWishListCubit(sl<WishListRepository>()),
      child: const WishListScreenBody(),
    );
  }
}

class WishListScreenBody extends StatefulWidget {
  const WishListScreenBody({super.key});

  @override
  State<WishListScreenBody> createState() => _WishListScreenBodyState();
}

class _WishListScreenBodyState extends State<WishListScreenBody> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  @override
  void initState() {
    context.read<GetWishListCubit>().getWishList();
    super.initState();
  }

  List<GetWishListModel> wishList = [];

  Future<void> _deleteItem(int index) async {
    if (index < 0 || index >= wishList.length) return;

    final removedItem = wishList[index];
    final originalIndex = index;

    // 1. Remove from UI immediately (Optimistic Update)
    setState(() {
      wishList.removeAt(index);
    });

    // 2. Animate the removal
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(animation, removedItem),
      duration: const Duration(milliseconds: 300),
    );

    try {
      await context.read<GetWishListCubit>().removeFromWishList(
        productId: removedItem.productId!,
      );

      HomeScreen.homeKey.currentState?.refreshWishListAndCartList();

      // Show success feedback
    } catch (error) {
      // 4. Rollback on error - re-add the item
      setState(() {
        wishList.insert(originalIndex, removedItem);
      });

      _listKey.currentState?.insertItem(
        originalIndex,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  Widget _buildRemovedItem(Animation<double> animation, GetWishListModel item) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: ProductWishList(
          removeFromWishList: () {},
          imageUrl: item.productImage ?? '',
          title: item.productName ?? '',
          price: item.price ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
        CustomSliverAppBar(
          appBarHeight: 70.h,
          title: Text(
            "المفضلة",
            style: AppStyle.styleRegular18(
              context,
            ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
          ),
          isShownDivider: true,
          isShoppingCartShown: false,
          isShownActions: false,
          actions: const [],
        ),

        SliverToBoxAdapter(child: SizedBox(height: 25.h)),
        BlocListener<GetWishListCubit, GetWishListState>(
          listener: (context, state) {
            if (state is GetWishListSuccess) {
              setState(() {
                wishList = state.wishLists;
              });
            }
          },
          child: BlocBuilder<GetWishListCubit, GetWishListState>(
            builder: (context, state) {
              if (state is GetWishListLoading && wishList.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                );
              }

              // if (state is GetWishListSuccess) {

              //   return SliverList.builder(
              //     itemCount: state.wishLists.length,
              //     itemBuilder: (context, index) {
              //       return ProductWishList(
              //         removeFromWishList: () {},
              //         imageUrl: state.wishLists[index].productImage!,
              //         title: state.wishLists[index].productName!,
              //         price: state.wishLists[index].price!,
              //       );
              //     },
              //   );
              // }

              if (state is GetWishListError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(state.error.icon, color: Colors.red, size: 50),

                        SizedBox(height: 20.h),
                        Text(
                          state.error.message,
                          style: TextStyle(fontSize: 16.sp, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 10.h),

                        ElevatedButton(
                          onPressed: () {
                            context.read<GetWishListCubit>().getWishList();
                          },
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverAnimatedList(
                key: _listKey,
                initialItemCount: wishList.length,
                itemBuilder: (context, index, animation) {
                  return _buildAnimatedItem(animation, index);
                },
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 120.h)),
      ],
    );
  }

  Widget _buildAnimatedItem(Animation<double> animation, int index) {
    if (index >= wishList.length) return Container();

    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: ProductWishList(
          removeFromWishList: () => _deleteItem(index),
          imageUrl: wishList[index].productImage!,
          title: wishList[index].productName!,
          price: wishList[index].price!,
        ),
      ),
    );
  }
}
