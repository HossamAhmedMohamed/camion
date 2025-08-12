import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/toggle_nav_bar/toggle_nav_bar_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order.dart';
import 'package:camion/features/order_status/presentation/widgets/status_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  static List<CategoriesModel> categories = [
    CategoriesModel(onTap: () {}, title: "الكل"),
    CategoriesModel(onTap: () {}, title: "قيد التنفيذ"),
    CategoriesModel(onTap: () {}, title: "المكتملة"),
    CategoriesModel(onTap: () {}, title: "الملغية"),
  ];

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    context.read<GetOrdersCubit>().getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
          actions: const [],

          isShoppingCartShown: false,
          isShownActions: false,
          isShownDivider: true,
        ),

        SliverToBoxAdapter(child: SizedBox(height: 25.h)),

        // SliverToBoxAdapter(
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 8.w),
        //     padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),

        //     decoration: ShapeDecoration(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(50.r),
        //       ),
        //       color: AppColors.lightGray,
        //     ),

        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: List.generate(
        //         MyOrdersScreen.categories.length,
        //         (index) =>
        //             BlocSelector<ToggleNavBarCubit, ToggleNavBarState, bool>(
        //               selector: (state) {
        //                 return state.index == index;
        //               },
        //               builder: (context, state) {
        //                 return GestureDetector(
        //                   onTap: () {
        //                     context.read<ToggleNavBarCubit>().toggle(index);
        //                   },

        //                   child: StatusNavBar(
        //                     isActive: state,
        //                     title: MyOrdersScreen.categories[index].title,
        //                   ),
        //                 );
        //               },
        //             ),
        //       ),
        //     ),
        //   ),
        // ),
        // SliverToBoxAdapter(child: SizedBox(height: 15.h)),
        BlocBuilder<GetOrdersCubit, GetOrdersState>(
          builder: (context, state) {
            if (state is GetOrdersLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              );
            }

            if (state is GetOrdersSuccess) {
              List<Map<String, dynamic>> allCartItems = [];

              for (var order in state.orders) {
                for (var cartItem in order.cartItems) {
                  allCartItems.add({
                    'orderId': order.id,
                    'cartItem': cartItem,
                    'orderDate': order.createdAt,
                  });
                }
              }

              return SliverList.builder(
                itemCount: allCartItems.length,
                itemBuilder: (context, index) {
                  final item = allCartItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: CustomOrder(
                      numberOfRequest: item['orderId'],
                      totalPrice: item['cartItem'].price!,
                      quantity: item['cartItem'].quantity!,
                      date: item['orderDate'],
                    ),
                  );
                },
              );
            }

            if (state is GetOrdersError) {
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
                          context.read<GetOrdersCubit>().getOrders();
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

        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}
