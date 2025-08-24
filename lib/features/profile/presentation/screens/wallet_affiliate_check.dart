import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/get_affiliate_status_cubit/get_affiliate_status_cubit.dart';
import 'package:camion/features/join_us/presentation/screens/pending_screen.dart';
import 'package:camion/features/join_us/presentation/screens/rejected_screen.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WalletAffiliateCheckScreen extends StatefulWidget {
  const WalletAffiliateCheckScreen({super.key});

  @override
  State<WalletAffiliateCheckScreen> createState() => _WalletAffiliateCheckScreenState();
}

class _WalletAffiliateCheckScreenState extends State<WalletAffiliateCheckScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAffiliateStatusCubit>().getAffiliateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: BlocConsumer<GetAffiliateStatusCubit, GetAffiliateStatusState>(
          listener: (context, state) {
            if (state is GetAffiliateStatusSuccess) {
              final status = state.data.status;

              if (status == 'approved') {

                GoRouter.of(context).pushReplacement(AppRouter.myWallet);
              }
            }

            if (state is GetAffiliateStatusError) {
              final message = state.error.message;

              if (message == "Affiliate request not found") {
                GoRouter.of(context).pushReplacement(AppRouter.supplierWelcome);
              }
            }
          },
          builder: (context, state) {
            if (state is GetAffiliateStatusSuccess) {
              final status = state.data.status;
              if (status == "pending") {
                return const PendingScreen();
              }

              if (status == "rejected") {
                return const RejectedScreen();
              }
            }

            if (state is GetAffiliateStatusError) {
              final message = state.error.message;

              if (message != "Affiliate request not found") {
                return Center(
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
                          context
                              .read<GetAffiliateStatusCubit>()
                              .getAffiliateStatus();
                        },
                        child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ],
                  ),
                );
              }
            }
            return const CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          },
        ),
      ),
    );
  }
}
