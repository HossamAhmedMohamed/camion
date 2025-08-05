import 'dart:developer';

import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/custom_product_to_cart.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCartCubit(sl<CartRepository>()),
      child: const MyCartScreenBody(),
    );
  }
}

class MyCartScreenBody extends StatefulWidget {
  const MyCartScreenBody({super.key});

  @override
  State<MyCartScreenBody> createState() => _MyCartScreenBodyState();
}

class _MyCartScreenBodyState extends State<MyCartScreenBody> {
  @override
  void initState() {
    super.initState();
    _initCart();
  }

  Future<void> _initCart() async {
    final userData = await getUserData();
    if (mounted) {
      context.read<GetCartCubit>().getCart(
        token: userData['token']!,
        userId: userData['userId']!,
      );
    }
  }

  getUserId() async {
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');
    log(userId.toString());
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

  List<GetCartModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 15.h)),
              const CartSliverAppBar(title: "العربة"),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              BlocBuilder<GetCartCubit, GetCartState>(
                builder: (context, state) {
                  if (state is GetCartLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      ),
                    );
                  }

                  if (state is GetCartSuccess) {
                    cartList = state.cartList;
                    return SliverList.builder(
                      itemCount: state.cartList.length,
                      itemBuilder: (context, index) {
                        return ProductCartItem(
                          imageUrl: state.cartList[index].image!,
                          title: state.cartList[index].title!,
                          price: state.cartList[index].price!,
                          initialQuantity: state.cartList[index].quantity!,
                        );
                      },
                    );
                  }

                  if (state is GetCartError) {
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
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10.h),

                            ElevatedButton(
                              onPressed: () async {
                                final userData = await getUserData();
                                if (mounted) {
                                  context.read<GetCartCubit>().getCart(
                                    token: userData['token']!,
                                    userId: userData['userId']!,
                                  );
                                }
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
                  return SliverToBoxAdapter(child: Container());
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 120.h)),
            ],
          ),
        ),

        _buildCheckoutSection(context),
      ],
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: screenWidth > 800
          ? screenWidth / 260.h
          : screenWidth / 200.h,
      child: Container(
        // height: 220.h,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "90",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "التوصيل",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي الكل",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "100",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),

                  child: CustomElevatedButton(
                    height: 50.h,
                    padding: 0,
                    child: Text(
                      "المتابعة للدفع",
                      style: AppStyle.styleRegular15(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.confirmPayment, extra: cartList);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
