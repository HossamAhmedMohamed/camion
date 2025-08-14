 import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order_tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusScreenBody extends StatefulWidget {
  const OrderStatusScreenBody({super.key});

  @override
  State<OrderStatusScreenBody> createState() => _OrderStatusScreenBodyState();
}

class _OrderStatusScreenBodyState extends State<OrderStatusScreenBody> {
  List<CategoriesModel> categories = [
    CategoriesModel(onTap: () {}, title: "الكل"),
    CategoriesModel(onTap: () {}, title: "قيد التنفيذ"),
    CategoriesModel(onTap: () {}, title: "المكتملة"),
    CategoriesModel(onTap: () {}, title: "الملغية"),
  ];

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

        // const HomeSliverAppBar(),

         

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

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
        //         categories.length,
        //         (index) =>
        //             BlocSelector<PaymentMethodCubit, PaymentMethodState, bool>(
        //               selector: (state) {
        //                 return state.index == index;
        //               },
        //               builder: (context, state) {
        //                 return GestureDetector(
        //                   onTap: () {
        //                     context.read<PaymentMethodCubit>().changeIndex(
        //                       index,
        //                     );
        //                   },

        //                   child: StatusNavBar(
        //                     isActive: state,
        //                     title: categories[index].title,
        //                   ),
        //                 );
        //               },
        //             ),
        //       ),
        //     ),
        //   ),
        // ),

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

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
                  state.orders[index].items[0].image;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: OrderSuccessPage(
                      image: state.orders[index].items[0].image,
                      title: state.orders[index].items[0].title,
                      totalPrice: state.orders[index].items[0].price,
                      quantity: state.orders[index].items[0].quantity,
                      // date: state.orders[index].createdAt,
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
