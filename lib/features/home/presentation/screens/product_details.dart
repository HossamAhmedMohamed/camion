import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/config/widgets/custom_expansion_tile.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/presentation/logic/cubit/add_cart_cubit/add_cart_cubit.dart';
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';
import 'package:camion/features/home/presentation/logic/cubit/product_id_detailscubit/product_id_details_cubit.dart';
import 'package:camion/features/home/presentation/logic/cubit/toggle_product_id_images/toggle_product_id_images_cubit.dart';
import 'package:camion/features/home/presentation/widgets/product_id_image_skeletonizer.dart';
import 'package:camion/features/home/presentation/widgets/products_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});

  final String productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final pageController = PageController();

  @override
  void initState() {
    BlocProvider.of<ProductIdDetailsCubit>(
      context,
    ).getProductDetails(widget.productId);
    super.initState();
  }

  getUserId() async {
    final userId = await sl<SecureCacheHelper>().getData(key: 'id');

    return userId;
  }

  getToken() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    return token;
  }

  Future<Map<String, String>> getUserData() async {
    final token = await getToken();
    final userId = await getUserId();
    return {'token': token!, 'userId': userId!};
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  late AllProductModel prodcut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductIdDetailsCubit>(
            context,
          ).getProductDetails(widget.productId, forceRefresh: true);
        },
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              appBarHeight: 70.h,
              title: Text(
                "تفاصيل المنتج",
                style: AppStyle.styleRegular18(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
              ),
              leading: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                  size: 25.sp,
                ),
              ),

              isShownDivider: true,
            ),

            SliverToBoxAdapter(child: SizedBox(height: 15.h)),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                        BlocBuilder<
                          ProductIdDetailsCubit,
                          ProductIdDetailsState
                        >(
                          builder: (context, state) {
                            if (state is ProductIdDetailsLoading) {
                              return const Skeletonizer(
                                enabled: true,
                                child: ProductImageSkeleton(),
                              );
                            }

                            if (state is ProductIdDetailsLoaded) {
                              prodcut = state.productIdDetailsModel;
                              return PageView.builder(
                                controller: pageController,
                                onPageChanged: (index) {
                                  context
                                      .read<ToggleProductIdImagesCubit>()
                                      .toggle(index);
                                },
                                itemCount:
                                    state.productIdDetailsModel.images.length,
                                itemBuilder: (context, index) {
                                  return CustomCachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: state
                                        .productIdDetailsModel
                                        .images[index]
                                        .thumbnail,
                                  );
                                },
                              );
                            }

                            if (state is ProductIdDetailsError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      state.error.icon,
                                      color: Colors.red,
                                      size: 50,
                                    ),

                                    SizedBox(height: 20.h),
                                    Text(
                                      state.error.message,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: 10.h),

                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ProductIdDetailsCubit>()
                                            .getProductDetails(
                                              widget.productId,
                                            );
                                        ();
                                      },
                                      child: Text(
                                        'Retry',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Container();
                          },
                        ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        BlocBuilder<
                          ProductIdDetailsCubit,
                          ProductIdDetailsState
                        >(
                          builder: (context, state) {
                            if (state is ProductIdDetailsLoading) {
                              return const Skeletonizer(
                                enabled: true,
                                child: ProductInfoSkeleton(),
                              );
                            }
                            if (state is ProductIdDetailsLoaded) {
                              return Column(
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        state
                                            .productIdDetailsModel
                                            .images
                                            .length,
                                        (index) =>
                                            BlocBuilder<
                                              ToggleProductIdImagesCubit,
                                              ToggleProductIdImagesState
                                            >(
                                              builder: (context, state) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                  ),
                                                  width: state.index == index
                                                      ? 20.w
                                                      : 8.w,
                                                  height: 8.h,
                                                  decoration: BoxDecoration(
                                                    color: state.index == index
                                                        ? const Color(
                                                            0xFFD32F2F,
                                                          )
                                                        : Colors.grey.shade400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4.r,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.productIdDetailsModel.name,
                                          style: AppStyle.styleBold18(context),
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Image.asset(
                                        Assets.imagesSave,
                                        width: 25.w,
                                        height: 25.h,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.h),

                                  Row(
                                    children: [
                                      Text(
                                        '${state.productIdDetailsModel.prices.price}',
                                        style: AppStyle.styleBold20(context)
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),
                                      // SizedBox(width: 8.w),
                                      // Text(
                                      //   '${state.productIdDetailsModel.price.price}',
                                      //   style: AppStyle.styleRegular15(context)
                                      //       .copyWith(
                                      //         color: AppColors.gray,
                                      //         decoration:
                                      //             TextDecoration.lineThrough,
                                      //       ),
                                      // ),
                                    ],
                                  ),
                                ],
                              );
                            }

                            if (state is ProductIdDetailsError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      state.error.icon,
                                      color: Colors.red,
                                      size: 50,
                                    ),

                                    SizedBox(height: 20.h),
                                    Text(
                                      state.error.message,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: 10.h),

                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ProductIdDetailsCubit>()
                                            .getProductDetails(
                                              widget.productId,
                                            );
                                        ();
                                      },
                                      child: Text(
                                        'Retry',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Container();
                          },
                        ),

                        SizedBox(height: 5.h),

                        Row(
                          children: [
                            Text(
                              '4.5',
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: Colors.grey.shade600),
                            ),

                            SizedBox(width: 5.w),
                            ...List.generate(5, (index) {
                              return Icon(
                                index < 4.5.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20.r,
                              );
                            }),
                          ],
                        ),

                        SizedBox(height: 5.h),

                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: AppColors.gray,
                              size: 15.r,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '32 مشاهده',
                              style: AppStyle.styleRegular10(
                                context,
                              ).copyWith(color: AppColors.gray),
                            ),

                            SizedBox(width: 10.w),

                            Text(
                              '10 منذ ساعات',
                              style: AppStyle.styleRegular10(
                                context,
                              ).copyWith(color: AppColors.gray),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const ProductsSelectionOptions(),

                        SizedBox(height: 20.h),

                        const CustomExpansionTile(
                          title: "الوصف",
                          content:
                              "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                        ),

                        SizedBox(height: 20.h),

                        const CustomExpansionTile(
                          title: "طريقة الاستعمال",
                          content:
                              "هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة لا يمكن تغييرها هذه حقيقة مثبتة",
                        ),

                        SizedBox(height: 20.h),

                        Image.asset(
                          Assets.imagesProductRate,

                          // width: double.infinity,
                          // height: 120.h,
                        ),

                        SizedBox(height: 30.h),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AddCartCubit>().addToCart(
                                productId: prodcut.id.toString(),
                                title: prodcut.name,
                                price: prodcut.prices.price,
                                image: prodcut.images[0].thumbnail,
                                quantity: 1,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'أضف للعربة',
                                  style: AppStyle.styleRegular15(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),

                                SizedBox(width: 6.w),

                                SvgPicture.asset(
                                  Assets.imagesShoppingCartWhite,
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
