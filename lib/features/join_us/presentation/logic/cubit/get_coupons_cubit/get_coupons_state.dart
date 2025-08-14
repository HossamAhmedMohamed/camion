part of 'get_coupons_cubit.dart';


sealed class GetCouponsState {}

final class GetCouponsInitial extends GetCouponsState {}


final class GetCouponsLoading extends GetCouponsState {}


final class GetCouponsError extends GetCouponsState {
  final ApiErrorModel error;
  GetCouponsError({required this.error});
}

final class GetCouponsSuccess extends GetCouponsState {
  
  final List<GetCouponsModel> coupons;
  GetCouponsSuccess({required this.coupons});
}
