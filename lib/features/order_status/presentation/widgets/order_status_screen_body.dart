import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/features/cart/presentation/logic/cubit/payment_method_cubit.dart';
import 'package:camion/features/home/data/models/categories_model.dart';

import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/order_status/presentation/widgets/custom_order_tracking_widget.dart';
import 'package:camion/features/order_status/presentation/widgets/status_nav_bar.dart';
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
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeSliverAppBar(
           
        ),

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

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
                    BlocSelector<PaymentMethodCubit, PaymentMethodState, bool>(
                      selector: (state) {
                        return state.index == index;
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<PaymentMethodCubit>().changeIndex(
                              index,
                            );
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

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),

        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: const OrderSuccessPage(),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}
