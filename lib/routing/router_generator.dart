import 'package:camion/config/widgets/selecting_from_bottom_navbar.dart';
import 'package:camion/features/auth/presentation/screens/confirm_phone_number_screen.dart';
import 'package:camion/features/auth/presentation/screens/first_screen_if_first_time.dart';
import 'package:camion/features/auth/presentation/screens/login_screen.dart';
import 'package:camion/features/auth/presentation/screens/register_screen.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenerator {
  static GoRouter mainRouting = GoRouter(
    initialLocation: AppRouter.selectingFromBottomNavBar,
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text(state.error.toString())));
    },
    routes: [
      GoRoute(
        name: AppRouter.firstScreenIfFirstLaunch,
        path: AppRouter.firstScreenIfFirstLaunch,
        builder: (context, state) => const FirstScreenIfFirstTime(),
      ),

      GoRoute(
        name: AppRouter.login,
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        name: AppRouter.register,
        path: AppRouter.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        name: AppRouter.confirmPhoneNumberScreen,
        path: AppRouter.confirmPhoneNumberScreen,
        builder: (context, state) => const ConfirmPhoneNumberScreen(),
      ),

      GoRoute(
        name: AppRouter.selectingFromBottomNavBar,
        path: AppRouter.selectingFromBottomNavBar,
        builder: (context, state) => const SelectingFromBottomNavBar(),
      ),
    ],
  );
}
