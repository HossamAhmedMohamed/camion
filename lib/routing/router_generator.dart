import 'package:camion/config/widgets/selecting_from_bottom_navbar.dart';
import 'package:camion/core/services/cached_services/product_id_cache_service.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:camion/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:camion/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:camion/features/auth/presentation/logic/verify_cubit/verify_cubit.dart';
import 'package:camion/features/auth/presentation/screens/confirm_phone_number_screen.dart';
import 'package:camion/features/auth/presentation/screens/first_screen_if_first_time.dart';
import 'package:camion/features/auth/presentation/screens/login_screen.dart';
import 'package:camion/features/auth/presentation/screens/register_screen.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/toggle_payment_cubit/payment_method_cubit.dart';
import 'package:camion/features/cart/presentation/screens/confirm_address.dart';
import 'package:camion/features/cart/presentation/screens/confirm_payment_screen.dart';
import 'package:camion/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:camion/features/home/data/models/categories_model.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_id_detailscubit/product_id_details_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_add_cart_cubit/toggle_add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/screens/all_categories_screen.dart';
import 'package:camion/features/home/presentation/screens/category_screen.dart';
import 'package:camion/features/home/presentation/screens/product_details.dart';
import 'package:camion/features/home/presentation/screens/stories_screen.dart';
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
import 'package:camion/features/searching/presentation/screens/search_screen_with_products.dart';
import 'package:camion/main_production.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterGenerator {
  static GoRouter mainRouting = GoRouter(
    initialLocation: isLoggedInUser
        ? AppRouter.selectingFromBottomNavBar
        : AppRouter.login,
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
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(sl<AuthRepository>()),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.register,
        path: AppRouter.register,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(sl<AuthRepository>()),
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.confirmPhoneNumberScreen,
        path: AppRouter.confirmPhoneNumberScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => VerifyCubit(sl<AuthRepository>()),
          child: const ConfirmPhoneNumberScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.selectingFromBottomNavBar,
        path: AppRouter.selectingFromBottomNavBar,
        builder: (context, state) => BlocProvider(
          create: (context) => GetCartCubit(
            sl<CartRepository>()
          ),
          child: const SelectingFromBottomNavBar(),
        ),
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
          final extra = state.extra as String;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductIdDetailsCubit(
                  sl<HomeRepository>(),
                  ProductCacheService(),
                ),
              ),
              BlocProvider(create: (context) => ToggleProductIdImagesCubit()),
            ],
            child: ProductDetails(productId: extra),
          );
        },
      ),
      GoRoute(
        name: AppRouter.myCart,
        path: AppRouter.myCart,
        builder: (context, state) => BlocProvider(
          create: (context) => GetCartCubit(sl<CartRepository>()),
          child: const MyCartScreenBody(),
        ),
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

      GoRoute(
        name: AppRouter.searchScreenWithProducts,
        path: AppRouter.searchScreenWithProducts,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductsCubit(sl<HomeRepository>()),
            ),
            BlocProvider(create: (context) => ToggleAddCartCubit()),
          ],
          child: const SearchScreenWithProducts(),
        ),
      ),

      GoRoute(
        name: AppRouter.storiesView,
        path: AppRouter.storiesView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return StoryViewerScreen(
            initialIndex: extra['index'] as int,
            stories: extra['stories'] as List<StoriesModel>,
            durationPeriod: extra['duration'] as int,
            mediaType: extra['mediaType'] as String,
          );
        },
      ),

      GoRoute(
        name: AppRouter.allCategoriesScreen,
        path: AppRouter.allCategoriesScreen,
        builder: (context, state) {
          final extra = state.extra as List<CategoriesModel>;
          return AllCategoriesScreen(categories: extra);
        },
      ),
    ],
  );
}
