import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
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
  @override
  void initState() {
    _initCart();
    super.initState();
  }

  Future<void> _initCart() async {
    final userData = await getUserData();
    if (mounted) {
      context.read<GetWishListCubit>().getWishList(
        token: userData['token']!,
        userId: userData['userId']!,
      );
    }
  }

  getUserId() async {
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    return userId;
  }

  getToken() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    return token;
  }

  Future<Map<String, String>> getUserData() async {
    final token = await getToken();
    final userId = await getUserId();
    return {'token': token, 'userId': userId};
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
        BlocBuilder<GetWishListCubit, GetWishListState>(
          builder: (context, state) {
            if (state is GetWishListLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              );
            }

            if (state is GetWishListSuccess) {
              return SliverList.builder(
                itemCount: state.wishLists.length,
                itemBuilder: (context, index) {
                  return ProductWishList(
                    imageUrl: state.wishLists[index].productImage!,
                    title: state.wishLists[index].productName!,
                    price: state.wishLists[index].price!,
                  );
                },
              );
            }

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
                        onPressed: () async {
                          final userData = await getUserData();

                          if (mounted) {
                            context.read<GetWishListCubit>().getWishList(
                              token: userData['token']!,
                              userId: userData['userId']!,
                            );
                          }
                        },
                        child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverToBoxAdapter(child: Container());
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 120.h)),
      ],
    );
  }
}
