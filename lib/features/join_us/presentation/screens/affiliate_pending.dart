// import 'package:camion/features/join_us/presentation/logic/cubit/get_affiliate_status_cubit/get_affiliate_status_cubit.dart';
// import 'package:camion/features/join_us/presentation/screens/supplier_account.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AffiliatePending extends StatefulWidget {
//   const AffiliatePending({super.key});

//   @override
//   State<AffiliatePending> createState() => _AffiliatePendingState();
// }

// class _AffiliatePendingState extends State<AffiliatePending> {
//   @override
//   void initState() {
//     context.read<GetAffiliateStatusCubit>().getAffiliateStatus();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: BlocConsumer<GetAffiliateStatusCubit, GetAffiliateStatusState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           if (state is GetAffiliateStatusSuccess) {
//             final message = state.data["status"];
//             message == 'pending'
//                 ? Text(
//                     "pending....",
//                     style: TextStyle(color: Colors.red, fontSize: 35.sp),
//                   )
//                 : message == 'rejected'
//                 ? Text(
//                     "rejected",
//                     style: TextStyle(color: Colors.red, fontSize: 35.sp),
//                   )
//                 : const SupplierAccountScreen();
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
