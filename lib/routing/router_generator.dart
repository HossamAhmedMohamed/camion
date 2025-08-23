import 'package:camion/config/widgets/selecting_from_bottom_navbar.dart';
import 'package:camion/core/services/cached_services/product_id_cache_service.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:camion/features/auth/presentation/logic/login_cubit/login_cubit.dart';
import 'package:camion/features/auth/presentation/logic/register_cubit/register_cubit.dart';
import 'package:camion/features/auth/presentation/logic/send_user_shipping_cubit/send_user_shipping_address_cubit.dart';
import 'package:camion/features/auth/presentation/logic/verify_cubit/verify_cubit.dart';
import 'package:camion/features/auth/presentation/screens/confirm_phone_number_screen.dart';
import 'package:camion/features/auth/presentation/screens/first_screen_if_first_time.dart';
import 'package:camion/features/auth/presentation/screens/login_screen.dart';
import 'package:camion/features/auth/presentation/screens/register_screen.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/toggle_payment_cubit/payment_method_cubit.dart';
import 'package:camion/features/auth/presentation/screens/confirm_address.dart';
import 'package:camion/features/cart/presentation/screens/confirm_payment_screen.dart';
import 'package:camion/features/cart/presentation/screens/my_cart_screen.dart';
import 'package:camion/features/cart/presentation/screens/payment_web_page.dart';
import 'package:camion/features/home/data/models/categories_model/get_categories_model.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:camion/features/home/data/repository/home_repo.dart';
import 'package:camion/features/home/presentation/logic/cubit/create_review_cubit/create_review_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/get_review_cubit/get_review_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_id_detailscubit/product_id_details_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/products_cubit/products_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_add_cart_cubit/toggle_add_cart_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/screens/all_categories_screen.dart';
import 'package:camion/features/home/presentation/screens/category_screen.dart';
import 'package:camion/features/home/presentation/screens/products_by_category_screen.dart';
import 'package:camion/features/home/presentation/screens/product_details.dart';
import 'package:camion/features/home/presentation/screens/stories_screen.dart';
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/create_coupon_cubit/create_coupon_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/get_affiliate_status_cubit/get_affiliate_status_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/Affiliate_sign_cubit/affiliate_sign_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/get_coupons_cubit/get_coupons_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_join_us_gender/toggle_join_us_cubit.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_social_media_cubit/toggle_social_media_selecting_cubit.dart';
import 'package:camion/features/join_us/presentation/screens/check_affiliate_or_not.dart';
import 'package:camion/features/join_us/presentation/screens/create_code_screen.dart';
import 'package:camion/features/join_us/presentation/screens/join_us_screen.dart';
import 'package:camion/features/join_us/presentation/screens/my_coupons_screen.dart';
import 'package:camion/features/join_us/presentation/screens/select_countries_of_supplier.dart';
import 'package:camion/features/join_us/presentation/screens/select_social_media_screen.dart';
import 'package:camion/features/join_us/presentation/screens/affiliate_account.dart';
import 'package:camion/features/join_us/presentation/screens/welcome_screen.dart';
import 'package:camion/features/notifications/data/repository/notification_repo.dart';
import 'package:camion/features/notifications/presentation/logic/cubit/notifications_cubit.dart';
import 'package:camion/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:camion/features/order_status/data/models/order_model/order_model.dart';
import 'package:camion/features/order_status/data/repository/order_status_repo.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/create_order_cubit/create_order_cubit.dart';
import 'package:camion/features/order_status/presentation/screens/order_details.dart';
import 'package:camion/features/profile/data/repository/profie_repo.dart';
import 'package:camion/features/profile/presentation/logic/cubit/get_user_cubit/get_user_cubit.dart';
import 'package:camion/features/profile/presentation/logic/cubit/log_out_cubit/log_out_cubit.dart';
import 'package:camion/features/profile/presentation/logic/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:camion/features/profile/presentation/screens/account_settings_screen.dart';
import 'package:camion/features/profile/presentation/screens/change_language_screen.dart';
import 'package:camion/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:camion/features/profile/presentation/screens/feed_back_screen.dart';
import 'package:camion/features/profile/presentation/screens/help_screen.dart';
import 'package:camion/features/profile/presentation/screens/my_info.dart';
import 'package:camion/features/profile/presentation/screens/my_wallet_screen.dart';
import 'package:camion/features/profile/presentation/screens/privacy_and_return_policy_scren.dart';
import 'package:camion/features/profile/presentation/screens/profile_screen.dart';
import 'package:camion/features/profile/presentation/screens/settings_screen.dart';
import 'package:camion/features/searching/presentation/screens/search_filter_screen.dart';
import 'package:camion/features/searching/presentation/screens/search_screen_with_products.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/add_to_wish_list/wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
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
    // initialLocation: AppRouter.login,
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
        name: AppRouter.profileScreen,
        path: AppRouter.profileScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => LogOutCubit(),
          child: const ProfileScreenBody(),
        ),
      ),

      GoRoute(
        name: AppRouter.selectingFromBottomNavBar,
        path: AppRouter.selectingFromBottomNavBar,
        builder: (context, state) => BlocProvider(
          create: (context) => GetCartCubit(sl<CartRepository>()),
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

              BlocProvider(
                create: (context) => AddCartCubit(sl<CartRepository>()),
              ),

              BlocProvider(
                create: (context) => GetCartCubit(sl<CartRepository>()),
              ),

              BlocProvider(
                create: (context) =>
                    AddToWishListCubit(sl<WishListRepository>()),
              ),

              BlocProvider(
                create: (context) => GetWishListCubit(sl<WishListRepository>()),
              ),

              BlocProvider(
                create: (context) => GetReviewCubit(sl<HomeRepository>()),
              ),

              BlocProvider(
                create: (context) => CreateReviewCubit(sl<HomeRepository>()),
              ),
            ],
            child: ProductDetails(productId: extra),
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
        builder: (context, state) {
          final extra = state.extra as List<GetCartModel>;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentMethodCubit()),
              BlocProvider(
                create: (context) =>
                    CreateOrderCubit(sl<OrderStatusRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    CreateOrderCubit(sl<OrderStatusRepository>()),
              ),
            ],
            child: ConfirmPaymentScreen(cartList: extra),
          );
        },
      ),

      GoRoute(
        name: AppRouter.confirmAddress,
        path: AppRouter.confirmAddress,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(create: (context) => PaymentMethodCubit()),
              BlocProvider(
                create: (context) =>
                    SendUserShippingAddressCubit(sl<AuthRepository>()),
              ),
            ],
            child: const ConfirmAddress(),
          );
        },
      ),

      GoRoute(
        name: AppRouter.myWallet,
        path: AppRouter.myWallet,
        builder: (context, state) => const MyWalletScreen(),
      ),

      GoRoute(
        name: AppRouter.notificationScreen,
        path: AppRouter.notificationScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => NotificationsCubit(sl<NotificationRepository>()),
          child: const NotificationsScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.searchFilter,
        path: AppRouter.searchFilter,
        builder: (context, state) => const SearchFilterScreen(),
      ),

      GoRoute(
        name: AppRouter.joinUs,
        path: AppRouter.joinUs,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ToggleJoinUsCubit()),
            BlocProvider(
              create: (context) =>
                  AffiliateSignCubit(sl<AffiliateRepository>()),
            ),
          ],
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
        builder: (context, state) => const AffiliateAccountScreen(),
      ),

      GoRoute(
        name: AppRouter.myCodings,
        path: AppRouter.myCodings,
        builder: (context, state) => BlocProvider(
          create: (context) => GetCouponsCubit(sl<AffiliateRepository>()),
          child: const MyCouponsScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.createCode,
        path: AppRouter.createCode,
        builder: (context, state) => BlocProvider(
          create: (context) => CreateCouponCubit(sl<AffiliateRepository>()),
          child: const CreateCodeScreen(),
        ),
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
          final extra = state.extra as List<GeTCategoriesModel>;
          return BlocProvider(
            create: (context) => GetCartCubit(sl<CartRepository>()),
            child: AllCategoriesScreen(categories: extra),
          );
        },
      ),

      // GoRoute(
      //   name: AppRouter.myOrders,
      //   path: AppRouter.myOrders,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => ToggleNavBarCubit(),
      //     child: const MyOrdersScreen(),
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.orderDetails,
      //   path: AppRouter.orderDetails,

      //   builder: (context, state) {
      //     final extra = state.extra as Map<String, Object>;
      //     return OrderDetailsScreen(
      //       items: extra['items'] as List<OrderItemModel>,
      //       numberOfOrder: extra['numberOfOrder'] as String,
      //       orderDate: extra['orderDate'] as DateTime,
      //       totalPrice: extra['totalPrice'] as String,
      //       deliveryCost: extra['deliveryCost'] as String,
      //       paymentMethod: extra['paymentMethod'] as String,
      //       shippingAddress: extra['shippingAddress'] as String,
      //     );
      //   },
      // ),
      GoRoute(
        path: AppRouter.orderDetailsScreen,
        name: AppRouter.orderDetailsScreen,

        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return OrderDetailsScreen(
            items: extra['items'] as List<OrderItemModel>,
            numberOfOrder: extra['numberOfOrder'] as String,
            orderDate: extra['orderDate'] as DateTime,
            totalPrice: extra['totalPrice'] as String,
            deliveryCost: extra['deliveryCost'] as String,
            paymentMethod: extra['paymentMethod'] as String,
            shippingAddress: extra['shippingAddress'] as String,
          );
        },
      ),

      GoRoute(
        name: AppRouter.myInfo,
        path: AppRouter.myInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => GetUserCubit(sl<ProfileRepository>()),
          child: const MyInfoScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.editInfo,
        path: AppRouter.editInfo,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UpdateUserCubit(sl<ProfileRepository>()),
              ),
              BlocProvider(
                create: (context) => GetUserCubit(sl<ProfileRepository>()),
              ),
            ],
            child: EditInfoScreen(
              fullName: extra['fullName'],
              phone: extra['phone'],
              email: extra['email'],
            ),
          );
        },
      ),

      GoRoute(
        name: AppRouter.settings,
        path: AppRouter.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        name: AppRouter.changeLanuage,
        path: AppRouter.changeLanuage,
        builder: (context, state) => const ChangeLanguageScreen(),
      ),

      GoRoute(
        name: AppRouter.accountSettings,
        path: AppRouter.accountSettings,
        builder: (context, state) => BlocProvider(
          create: (context) => LogOutCubit(),
          child: const AccountSettingsScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.help,
        path: AppRouter.help,
        builder: (context, state) => const HelpScreen(),
      ),

      GoRoute(
        name: AppRouter.productByCategory,
        path: AppRouter.productByCategory,
        builder: (context, state) {
          final extra = state.extra as String;
          return ProductsByCategoryScreen(slug: extra);
        },
      ),

      // GoRoute(
      //   name: AppRouter.affiliateStatus,
      //   path: AppRouter.affiliateStatus,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) =>
      //         GetAffiliateStatusCubit(sl<SupplierRepository>()),
      //     child: const AffiliatePending(),
      //   ),
      // ),
      GoRoute(
        name: AppRouter.affiliateCheckScreen,
        path: AppRouter.affiliateCheckScreen,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              GetAffiliateStatusCubit(sl<AffiliateRepository>()),
          child: const AffiliateCheckScreen(),
        ),
      ),

      GoRoute(
        name: AppRouter.paymentWebPage,
        path: AppRouter.paymentWebPage,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PaymentWebViewPage(
            checkoutUrl: extra['checkoutUrl'] as String,
            // orderId: extra['orderId'] as String,
          );
        },
      ),

      GoRoute(
        name: AppRouter.privacyScreen,
        path: AppRouter.privacyScreen,
        builder: (context, state) => const PrivacyAndReturnPolicyScren(),
      ),

      GoRoute(
        name: AppRouter.feedBackScreen,
        path: AppRouter.feedBackScreen,
        builder: (context, state) => const FeedBackScreen(),
      ),
    ],
  );
}
