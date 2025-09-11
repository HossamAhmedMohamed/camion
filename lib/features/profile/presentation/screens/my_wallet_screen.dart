import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_list_tile.dart';
import 'package:camion/config/widgets/expanded_row_for_user.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/presentation/logic/cubit/get_all_transations_cubit/get_all_transations_cubit.dart';
import 'package:camion/features/profile/presentation/logic/cubit/get_wallet_cubit/get_wallet_balance_cubit.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:camion/features/profile/presentation/widgets/wallet_widget.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  void initState() {
    context.read<GetWalletBalanceCubit>().getWalletBalance();
    context.read<GetAllTransationsCubit>().getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          ProfileSliverAppBar(
            title: Text(
               S.of(context).my_wallet,
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            isShoppingCartShown: false,
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 25.sp,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: BlocBuilder<GetWalletBalanceCubit, GetWalletBalanceState>(
              builder: (context, state) {
                if (state is GetWalletBalanceSuccess) {
                  return WalletCard(
                    totalAmount: state.data["walletBalance"].toString(),
                  );
                }
                return const WalletCard(totalAmount: "0.00");
              },
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 40.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomElevatedButton(
                onPressed: () async {
                  final phone = "+201158778592";
                  final url = Uri.parse("https://wa.me/$phone");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    Fluttertoast.showToast(
                      backgroundColor: Colors.red,
                      gravity: ToastGravity.TOP,
                      msg: "Unable to open WhatsApp",
                    );
                  }
                },
                widget: Image.asset(Assets.imagesRefresh),
                child: Text(
                  S.of(context).withdraw,
                  style: AppStyle.styleRegular15(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ExpandedRowForUserImplementation(
                // firstTitle: 'العمليات',
                secondTitle:  S.of(context).all,
                onTapOnSecondTitle: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          BlocBuilder<GetAllTransationsCubit, GetAllTransationsState>(
            builder: (context, state) {
              if (state is GetAllTransationsSuccess) {
                final tranaction = state.data;

                return SliverList.builder(
                  itemCount: tranaction.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomListTile(
                          title: tranaction[index].description.toString(),
                          subtitle: Text(
                            DateFormat("EEE d MMMM, yyyy").format(
                              DateTime.parse(
                                tranaction[index].createdAt.toString(),
                              ),
                            ),
                            style: AppStyle.styleRegular12(context).copyWith(
                              color: AppColors.black50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            tranaction[index].amount.toString(),
                            style: AppStyle.styleBold18(
                              context,
                            ).copyWith(color: const Color(0xFF244643)),
                          ),
                        ),

                        const Row(
                          children: [
                            Expanded(child: Divider(color: AppColors.paleGray)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
              return SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return   Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: [
                        CustomListTile(title: S.of(context).transactions),

                        const Row(
                          children: [
                            Expanded(child: Divider(color: AppColors.paleGray)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
