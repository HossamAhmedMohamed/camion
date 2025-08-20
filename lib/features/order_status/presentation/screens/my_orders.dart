import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_order_status_cubit/get_order_status_cubit.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/toggle_nav_bar/toggle_nav_bar_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order.dart';
import 'package:camion/features/order_status/presentation/widgets/status_nav_bar.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

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
    List<CategoriesModel> categories = [
      CategoriesModel(
        onTap: () {
          context.read<GetOrdersCubit>().getOrders();
        },
        title: "All",
      ),
      CategoriesModel(
        onTap: () {
          context.read<GetOrderStatusCubit>().getOrderStatus(status: "paid");
        },
        title: "Paid",
      ),
      CategoriesModel(
        onTap: () {
          context.read<GetOrderStatusCubit>().getOrderStatus(
            status: "complete",
          );
        },
        title: "Complete",
      ),
      CategoriesModel(
        onTap: () {
          context.read<GetOrderStatusCubit>().getOrderStatus(
            status: "delivered",
          );
        },
        title: "Delivered",
      ),
    ];
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 15.h)),

        CustomSliverAppBar(
          appBarHeight: 70.h,
          title: Text(
            "My Orders",
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
                            context.read<ToggleNavBarCubit>().toggle(index).then((_) =>
                            categories[index].onTap());
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
              return SliverList.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];

                  double totalPrice = order.items.fold(0, (sum, item) {
                    return sum + (double.tryParse(item.price) ?? 0);
                  });

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        final extra = {
                          'items': state.orders[index].items,
                          'numberOfOrder': order.id,
                          'totalPrice': totalPrice.toStringAsFixed(2),
                          'orderDate': order.createdAt,
                          'deliveryCost': order
                              .customerData!
                              .shippingOption!
                              .cost
                              .toString(),
                          'paymentMethod': order.paymentMethod,
                          'shippingAddress':
                              "${order.customerData!.shippingAddress!.city} ${order.customerData!.shippingAddress!.address1} ${order.customerData!.shippingAddress!.address2}",
                        };
                        GoRouter.of(
                          context,
                        ).push(AppRouter.orderDetailsScreen, extra: extra);
                      },
                      child: CustomOrder(
                        numberOfRequest: order.id,
                        totalPrice: totalPrice.toStringAsFixed(2),
                        numberOfProducts: order.items.length,
                        date: order.createdAt,
                        onTapOnOrderDetails: () {
                          final extra = {
                            'items': state.orders[index].items,
                            'numberOfOrder': order.id,
                            'totalPrice': totalPrice.toStringAsFixed(2),
                            'orderDate': order.createdAt,
                            'deliveryCost': order
                                .customerData!
                                .shippingOption!
                                .cost
                                .toString(),
                            'paymentMethod': order.paymentMethod,
                            'shippingAddress':
                                "${order.customerData!.shippingAddress!.city} ${order.customerData!.shippingAddress!.address1} ${order.customerData!.shippingAddress!.address2}",
                          };
                          GoRouter.of(
                            context,
                          ).push(AppRouter.orderDetailsScreen, extra: extra);
                        },
                        isOrderPaied: order.isPaid,
                        isOrderShipped: order.isDelivered,
                        orderConfirmationTime: order.createdAt,
                        paidSubtitle: order.isPaid
                            ? "Your order has been successfully paid"
                            : "Your order has not been paid yet",
                        shippedSubtitle: order.isDelivered
                            ? "Your order has been successfully delivered"
                            : "Your order has not been delivered yet",
                      ),
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
