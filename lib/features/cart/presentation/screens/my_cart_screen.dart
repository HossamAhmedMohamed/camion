import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:camion/features/cart/presentation/logic/cubit/get_cart_cubit/get_cart_cubit.dart';
import 'package:camion/features/cart/presentation/logic/cubit/update_cubit/update_cart_cubit.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/custom_product_to_cart.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetCartCubit(sl<CartRepository>())),
        BlocProvider(
          create: (context) => UpdateCartCubit(sl<CartRepository>()),
        ),
      ],
      child: const MyCartScreenBody(),
    );
  }
}

class MyCartScreenBody extends StatefulWidget {
  const MyCartScreenBody({super.key});

  @override
  State<MyCartScreenBody> createState() => _MyCartScreenBodyState();
}

class _MyCartScreenBodyState extends State<MyCartScreenBody> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  List<GetCartModel> cartList = [];

  @override
  void initState() {
    super.initState();
    context.read<GetCartCubit>().getCart();
  }

  Future<void> _deleteItem(int index) async {
    if (index < 0 || index >= cartList.length) return;

    final removedItem = cartList[index];
    final originalIndex = index;

    // 1. Remove from UI immediately (Optimistic Update)
    setState(() {
      cartList.removeAt(index);
    });

    // 2. Animate the removal
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(animation, removedItem),
      duration: const Duration(milliseconds: 300),
    );

    try {
      await context.read<UpdateCartCubit>().deleteFromCart(
        productId: removedItem.productId!,
      );
      HomeScreen.homeKey.currentState?.refreshWishListAndCartList();

      // Show success feedback
    } catch (error) {
      // 4. Rollback on error - re-add the item
      setState(() {
        cartList.insert(originalIndex, removedItem);
      });

      _listKey.currentState?.insertItem(
        originalIndex,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  Widget _buildRemovedItem(Animation<double> animation, GetCartModel item) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: ProductCartItem(
          productId: item.productId ?? '',
          imageUrl: item.image ?? '',
          title: item.title ?? '',
          price: item.price ?? '',
          initialQuantity: item.quantity ?? 1,
          onDelete: () {}, // Empty callback since it's being removed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                const CartSliverAppBar(title: "Cart"),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                _buildCartContent(),
                SliverToBoxAdapter(child: SizedBox(height: 120.h)),
              ],
            ),
          ),
          _buildCheckoutSection(context),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetCartCubit, GetCartState>(
          listener: (context, state) {
            if (state is GetCartSuccess) {
              setState(() {
                cartList = List.from(state.cartList);
              });
            }
          },
        ),

        // BlocListener<UpdateCartCubit, UpdateCartState>(
        //   listener: (context, state) {
        //     if (state is UpdateCartSuccess) {
        //       context.read<GetCartCubit>().getCart();
        //     }
        //   },
        // ),
      ],
      child: BlocBuilder<GetCartCubit, GetCartState>(
        builder: (context, state) {
          if (state is GetCartLoading && cartList.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            );
          }

          if (state is GetCartError && cartList.isEmpty) {
            return _buildErrorState(state);
          }

          return SliverAnimatedList(
            key: _listKey,
            initialItemCount: cartList.length,
            itemBuilder: (context, index, animation) {
              return _buildAnimatedItem(animation, index);
            },
          );
        },
      ),
    );
  }

  Widget _buildAnimatedItem(Animation<double> animation, int index) {
    if (index >= cartList.length) return Container();

    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: ProductCartItem(
          onDelete: () => _deleteItem(index),
          productId: cartList[index].productId!,
          imageUrl: cartList[index].image!,
          title: cartList[index].title!,
          price: cartList[index].price!,
          initialQuantity: cartList[index].quantity!,
        ),
      ),
    );
  }

  Widget _buildErrorState(GetCartError state) {
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
              onPressed: () => context.read<GetCartCubit>().getCart(),
              child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildEmptyState() {
  //   return SliverToBoxAdapter(
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(height: 100.h),
  //           Icon(
  //             Icons.shopping_cart_outlined,
  //             size: 80,
  //             color: Colors.grey[400],
  //           ),
  //           SizedBox(height: 20.h),
  //           Text(
  //             'العربة فارغة',
  //             style: AppStyle.styleRegular16(
  //               context,
  //             ).copyWith(color: Colors.grey[600]),
  //           ),
  //           SizedBox(height: 10.h),
  //           CustomElevatedButton(
  //             child: Text(
  //               'تسوق الآن',
  //               style: AppStyle.styleRegular14(
  //                 context,
  //               ).copyWith(color: Colors.white),
  //             ),
  //             onPressed: () => context.pop(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // bool _shouldUpdateList(List<GetCartModel> newList) {
  //   if (cartList.length != newList.length) return true;

  //   for (int i = 0; i < cartList.length; i++) {
  //     if (cartList[i].productId != newList[i].productId ||
  //         cartList[i].quantity != newList[i].quantity) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Rest of your code remains the same...
  Widget _buildCheckoutSection(BuildContext context) {
    if (cartList.isEmpty) return Container();

    // final totalAmount = _calculateTotal();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.h),
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // _buildPriceRow("اجمالي", "${totalAmount - 10}"),
            //       // SizedBox(height: 10.h),
            //       // _buildPriceRow("التوصيل", "10"),
            //       SizedBox(height: 10.h),
            //       _buildPriceRow(
            //         "اجمالي الكل",
            //         totalAmount.toStringAsFixed(2),
            //       ),
            //       SizedBox(height: 10.h),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomElevatedButton(
                  height: 50.h,
                  verticalPadding: 0,
                  onPressed: cartList.isNotEmpty
                      ? () => GoRouter.of(
                          context,
                        ).push(AppRouter.confirmPayment, extra: cartList)
                      : () {},
                  child: Text(
                    "Continue To Checkout",
                    style: AppStyle.styleRegular15(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPriceRow(String label, String value) {
  //   return Row(
  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         label,
  //         style: AppStyle.styleRegular16(
  //           context,
  //         ).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
  //       ),
  //       SizedBox(width: 20.w),
  //       Expanded(
  //         child: Text(
  //           overflow: TextOverflow.ellipsis,
  //           maxLines: 5,
  //           value,
  //           style: AppStyle.styleRegular16(context).copyWith(
  //             color: AppColors.primaryColor,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // double _calculateTotal() {
  //   // Calculate actual total from cartList
  //   double total = 0;
  //   for (var item in cartList) {
  //     total += (double.tryParse(item.price ?? '0') ?? 0) * (item.quantity ?? 1);
  //   }
  //   return total; // Adding delivery fee
  // }
}


// context.read<CreateOrderCubit>().createOrder(
                    //   cartList: widget.cartList,
                    //   taxPrice: "80",
                    //   shippingPrice: "100",
                    //   totalOrderPrice: "200",
                    //   shippingAddress: selectedAddress ?? "لم يتم تحديد عنوانك",
                    // );

                    // customizeModalBottomSheet(
                    //   title: "لقد تم تأكيد طلبك بنجاح",
                    //   screenWidth: screenWidth,
                    //   context: context,
                    //   content: Row(
                    //     children: [
                    //       Expanded(
                    //         child: CustomElevatedButton(
                    //           backgroundColor: AppColors.primaryColor,
                    //           child: Text(
                    //             "مشاهدة الطلب",
                    //             style: AppStyle.styleRegular15(
                    //               context,
                    //             ).copyWith(color: Colors.white),
                    //           ),
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //       SizedBox(width: 10.w),
                    //       Expanded(
                    //         child: CustomElevatedButton(
                    //           borderColor: AppColors.primaryColor,
                    //           backgroundColor: AppColors.white,
                    //           textColor: AppColors.primaryColor,
                    //           child: Text(
                    //             "متابعة التسوق",
                    //             style: AppStyle.styleRegular15(
                    //               context,
                    //             ).copyWith(color: AppColors.primaryColor),
                    //           ),
                    //           onPressed: () {
                    //             GoRouter.of(context).pushReplacement(
                    //               AppRouter.selectingFromBottomNavBar,
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );