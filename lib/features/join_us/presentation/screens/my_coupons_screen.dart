
import 'package:camion/features/join_us/presentation/logic/cubit/get_coupons_cubit/get_coupons_cubit.dart';
import 'package:camion/features/join_us/presentation/widgets/coupons_list_view_skeltonizer.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:camion/features/join_us/presentation/widgets/custom_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  @override
  void initState() {
    context.read<GetCouponsCubit>().getCouponCodeByAffiliateId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const CustomJoinUsSliverAppBar(title: "My Coupons"),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          BlocBuilder<GetCouponsCubit, GetCouponsState>(
            builder: (context, state) {
              if (state is GetCouponsLoading) {
                return SliverList.builder(
                  itemCount: 16,
                  itemBuilder: (context, index) => const Skeletonizer(
                    enabled: true,
                    child: CouponsListViewSkeletonizer(),
                  ),
                );
              }

              if (state is GetCouponsSuccess) {
                return SliverList.builder(
                  itemCount: state.coupons.length,
                  itemBuilder: (context, index) {
                    return CustomCoupon(
                      couponCode: state.coupons[index].code,
                      discountPercentage: state
                          .coupons[index]
                          .discountPercentage
                          .toString(),
                    );
                  },
                );
              }
              return SliverToBoxAdapter(child: Container());
            },
          ),
        ],
      ),
    );
  }
}
