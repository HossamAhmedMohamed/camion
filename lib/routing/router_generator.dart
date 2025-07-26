import 'package:camion/config/widgets/selecting_from_bottom_navbar.dart';
import 'package:camion/features/auth/presentation/screens/confirm_phone_number_screen.dart';
import 'package:camion/features/auth/presentation/screens/first_screen_if_first_time.dart';
import 'package:camion/features/auth/presentation/screens/login_screen.dart';
import 'package:camion/features/auth/presentation/screens/register_screen.dart';
import 'package:camion/features/cart/presentation/logic/cubit/payment_method_cubit.dart';
import 'package:camion/features/cart/presentation/screens/confirm_address.dart';
import 'package:camion/features/cart/presentation/screens/confirm_payment_screen.dart';
import 'package:camion/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:camion/features/home/data/models/product_model.dart';
import 'package:camion/features/home/presentation/screens/category_screen.dart';
import 'package:camion/features/home/presentation/screens/product_details.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_join_us_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_social_media_selecting_cubit.dart';
import 'package:camion/features/join_us/presentation/screens/create_code_screen.dart';
import 'package:camion/features/join_us/presentation/screens/join_us_screen.dart';
import 'package:camion/features/join_us/presentation/screens/my_codings_screen.dart';
import 'package:camion/features/join_us/presentation/screens/select_countries_of_supplier.dart';
import 'package:camion/features/join_us/presentation/screens/select_social_media_screen.dart';
import 'package:camion/features/join_us/presentation/screens/supplier_account.dart';
import 'package:camion/features/join_us/presentation/screens/welcome_screen.dart';
import 'package:camion/features/notifications/presentation/notifications_screen.dart';
import 'package:camion/features/profile/presentation/screens/my_wallet_screen.dart';
import 'package:camion/features/searching/presentation/screens/search_filter_screen.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterGenerator {
  static GoRouter mainRouting = GoRouter(
    initialLocation: AppRouter.supplierWelcome,
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

      GoRoute(
        name: AppRouter.category,
        path: AppRouter.category,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return CategoryScreen(
            title: extra['title'] as Widget,
            leading: extra['leading'] as Widget,
          );
        },
      ),

      GoRoute(
        name: AppRouter.productDetails,
        path: AppRouter.productDetails,

        builder: (context, state) {
          final extra = state.extra as ProductModel;
          return ProductDetails(
            productImages: extra.productImages,
            discountImage: extra.discountImage,
            productName: extra.productName,
            originalPrice: extra.originalPrice,
            discountedPrice: extra.discountedPrice,
            rating: extra.rating,
            reviewCount: extra.reviewCount,
            sellCount: extra.sellCount,
          );
        },
      ),

      GoRoute(
        name: AppRouter.myCart,
        path: AppRouter.myCart,
        builder: (context, state) => const MyCartScreen(),
      ),

      GoRoute(
        name: AppRouter.confirmPayment,
        path: AppRouter.confirmPayment,
        builder: (context, state) => BlocProvider(
          create: (context) => PaymentMethodCubit(),
          child: const ConfirmPaymentScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.confirmAddress,
        path: AppRouter.confirmAddress,
        builder: (context, state) => BlocProvider(
          create: (context) => PaymentMethodCubit(),
          child: const ConfirmAddress(),
        ),
      ),

      GoRoute(
        name: AppRouter.myWallet,
        path: AppRouter.myWallet,
        builder: (context, state) => const MyWalletScreen(),
      ),

      GoRoute(
        name: AppRouter.notificationScreen,
        path: AppRouter.notificationScreen,
        builder: (context, state) => const NotificationsScreen(),
      ),

      GoRoute(
        name: AppRouter.searchFilter,
        path: AppRouter.searchFilter,
        builder: (context, state) => const SearchFilterScreen(),
      ),

      GoRoute(
        name: AppRouter.joinUs,
        path: AppRouter.joinUs,
        builder: (context, state) => BlocProvider(
          create: (context) => ToggleJoinUsCubit(),
          child: const JoinUsScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.selectSocialMediaOfSupplierScreen,
        path: AppRouter.selectSocialMediaOfSupplierScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => ToggleSocialMediaSelectingCubit(),
          child: const SelectSocialMediaScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.selectCoutriesOfSupplier,
        path: AppRouter.selectCoutriesOfSupplier,
        builder: (context, state) => BlocProvider(
          create: (context) => ToggleSocialMediaSelectingCubit(),
          child: const SelectCountriesOfSupplier(),
        ),
      ),

      GoRoute(
        name: AppRouter.supplierWelcome,
        path: AppRouter.supplierWelcome,
        builder: (context, state) => const WelcomeScreen(),
      ),

      GoRoute(
        name: AppRouter.supplierAccount,
        path: AppRouter.supplierAccount,
        builder: (context, state) => const SupplierAccountScreen(),
      ),

        GoRoute(
        name: AppRouter.myCodings,
        path: AppRouter.myCodings,
        builder: (context, state) => const MyCodingsScreen(),
      ),

        GoRoute(
        name: AppRouter.createCode,
        path: AppRouter.createCode,
        builder: (context, state) => const CreateCodeScreen(),
      ),
    ],
  );
}
