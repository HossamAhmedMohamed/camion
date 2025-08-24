import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/get_orders_cubit/get_orders_cubit.dart';

import 'package:camion/features/order_status/presentation/logic/cubit/toggle_nav_bar/toggle_nav_bar_cubit.dart';
import 'package:camion/features/order_status/presentation/screens/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => PaymentMethodCubit()),
        BlocProvider(
          create: (context) => GetOrdersCubit(sl<OrderStatusRepository>()),
        ),
        BlocProvider(create: (context) => ToggleNavBarCubit()),

        // BlocProvider(
        //   create: (context) => OrderTrackingCubit(sl<OrderStatusRepository>()),
        // ),
      ],
      // child: const OrderStatusScreenBody(),
      child: const MyOrdersScreen(),
    );
  }
}
