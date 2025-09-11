 
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/wish_list/data/models/get_wish_list_model.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
import 'package:camion/features/wish_list/presentation/widgets/product_wish_list.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  static GlobalKey<WishListScreenBodyState> wishListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWishListCubit(sl<WishListRepository>()),
      child: WishListScreenBody(key: wishListKey),
    );
  }
}

class WishListScreenBody extends StatefulWidget {
  const WishListScreenBody({super.key});

  @override
  State<WishListScreenBody> createState() => WishListScreenBodyState();
}

class WishListScreenBodyState extends State<WishListScreenBody> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  List<GetWishListModel> wishList = [];
  Set<int> selectedItems = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    context.read<GetWishListCubit>().getWishList();
    super.initState();
  }

  refreshGetWishList() {
    context.read<GetWishListCubit>().getWishList();
  }

  // تبديل وضع التحديد
  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        selectedItems.clear();
      }
    });
  }

  // إضافة/إزالة عنصر من التحديد
  void toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
      } else {
        selectedItems.add(index);
      }
    });
  }

  // تحديد الكل
  void selectAll() {
    setState(() {
      selectedItems = Set<int>.from(
        List.generate(wishList.length, (index) => index),
      );
    });
  }

  // إلغاء تحديد الكل
  void deselectAll() {
    setState(() {
      selectedItems.clear();
    });
  }

  // مشاركة المنتجات المحددة
  Future<void> shareSelectedProducts() async {
    if (selectedItems.isEmpty) return;

    List<String> productLinks = [];

    for (int index in selectedItems) {
      if (index < wishList.length) {
        GetWishListModel product = wishList[index];

        String productLink =
            "https://camion-app.com/en/shop/${product.productId}";
        productLinks.add("${product.productName}: $productLink");
      }
    }

    String shareText =
        "Check out these amazing products I found:\n\n${productLinks.join('\n\n')}";

    await Share.share(shareText);
  }

  Future<void> _deleteItem(int index) async {
    if (index < 0 || index >= wishList.length) return;

    final removedItem = wishList[index];
    final originalIndex = index;

    // إزالة من قائمة التحديد إذا كان محدد
    setState(() {
      wishList.removeAt(index);
      selectedItems.remove(index);
      // تحديث المؤشرات للعناصر المحددة
      Set<int> updatedSelectedItems = {};
      for (int selectedIndex in selectedItems) {
        if (selectedIndex > index) {
          updatedSelectedItems.add(selectedIndex - 1);
        } else {
          updatedSelectedItems.add(selectedIndex);
        }
      }
      selectedItems = updatedSelectedItems;
    });

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(animation, removedItem),
      duration: const Duration(milliseconds: 300),
    );

    try {
      await context.read<GetWishListCubit>().removeFromWishList(
        productId: removedItem.productId!,
      );
      HomeScreen.homeKey.currentState?.refreshWishListAndCartList();
    } catch (error) {
      setState(() {
        wishList.insert(originalIndex, removedItem);
      });
      _listKey.currentState?.insertItem(
        originalIndex,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  Widget _buildRemovedItem(Animation<double> animation, GetWishListModel item) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: ProductWishList(
          removeFromWishList: () {},
          imageUrl: item.productImage ?? '',
          title: item.productName ?? '',
          price: item.price ?? '',
          isSelected: false,
          isSelectionMode: false,
          onSelectionChanged: (selected) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 15.h)),
        CustomSliverAppBar(
          appBarHeight: 70.h,
          title: Text(
            isSelectionMode
                ? "${selectedItems.length} ${S.of(context).selected}"
                : S.of(context).favorites,
            style: AppStyle.styleRegular18(
              context,
            ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
          ),
          isShownDivider: true,
          isShoppingCartShown: false,
          isShownActions: true,
          actions: [
            if (isSelectionMode) ...[
              // زر تحديد الكل/إلغاء تحديد الكل
              IconButton(
                onPressed: selectedItems.length == wishList.length
                    ? deselectAll
                    : selectAll,
                icon: Icon(
                  selectedItems.length == wishList.length
                      ? Icons.deselect
                      : Icons.select_all,
                  color: AppColors.black,
                ),
              ),
              // زر المشاركة
              if (selectedItems.isNotEmpty)
                IconButton(
                  onPressed: shareSelectedProducts,
                  icon: const Icon(Icons.share, color: AppColors.black),
                ),
              // زر الإلغاء
              IconButton(
                onPressed: toggleSelectionMode,
                icon: const Icon(Icons.close, color: AppColors.black),
              ),
            ] else ...[
              // زر التحديد
              IconButton(
                onPressed: wishList.isNotEmpty ? toggleSelectionMode : null,
                icon: const Icon(Icons.checklist, color: AppColors.black),
              ),
            ],
          ],
        ),
        SliverToBoxAdapter(child: SizedBox(height: 25.h)),

        // إضافة شريط معلومات عند التحديد
        if (isSelectionMode && selectedItems.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "${selectedItems.length} ${S.of(context).product}${selectedItems.length > 1 ? S.of(context).s : ''}  ${S.of(context).selected_for_sharing}.",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        BlocListener<GetWishListCubit, GetWishListState>(
          listener: (context, state) {
            if (state is GetWishListSuccess) {
              setState(() {
                wishList = state.wishLists;
                // إعادة تعيين التحديد إذا تغيرت القائمة
                selectedItems.clear();
                isSelectionMode = false;
              });
            }
          },
          child: BlocBuilder<GetWishListCubit, GetWishListState>(
            builder: (context, state) {
              if (state is GetWishListLoading && wishList.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                );
              }

              if (state is GetWishListError) {
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
                          onPressed: () {
                            context.read<GetWishListCubit>().getWishList();
                          },
                          child: Text(
                             S.of(context).retry,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (wishList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100.h),
                        Icon(
                          Icons.favorite_border,
                          size: 80.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                           S.of(context).Your_wishlist_is_empty,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                           S.of(context).add_some_products_to_your_favorites,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverAnimatedList(
                key: _listKey,
                initialItemCount: wishList.length,
                itemBuilder: (context, index, animation) {
                  return GestureDetector(
                    onTap: isSelectionMode
                        ? () => toggleSelection(index)
                        : () {
                            GoRouter.of(context).push(
                              AppRouter.productDetails,
                              extra: wishList[index].productId,
                            );
                          },
                    child: _buildAnimatedItem(animation, index),
                  );
                },
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 120.h)),
      ],
    );
  }

  Widget _buildAnimatedItem(Animation<double> animation, int index) {
    if (index >= wishList.length) return Container();

    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: ProductWishList(
          removeFromWishList: () => _deleteItem(index),
          imageUrl: wishList[index].productImage!,
          title: wishList[index].productName!,
          price: wishList[index].price!,
          isSelected: selectedItems.contains(index),
          isSelectionMode: isSelectionMode,
          onSelectionChanged: (selected) => toggleSelection(index),
        ),
      ),
    );
  }
}
