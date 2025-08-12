part of 'create_coupon_cubit.dart';

sealed class CreateCouponState {}

final class CreateCouponInitial extends CreateCouponState {}

final class CreateCouponLoading extends CreateCouponState {}

final class CreateCouponSuccess extends CreateCouponState {}

final class CreateCouponError extends CreateCouponState {
  ApiErrorModel error;
  CreateCouponError({required this.error});
}


