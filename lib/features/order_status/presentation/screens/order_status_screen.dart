import 'package:camion/features/cart/presentation/logic/cubit/payment_method_cubit.dart';
import 'package:camion/features/order_status/presentation/widgets/order_status_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodCubit(),
      child: const OrderStatusScreenBody(),
    );
  }
}
