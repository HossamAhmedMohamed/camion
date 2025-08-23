part of 'apply_coupon_cubit.dart';

sealed class ApplyCouponState {}

final class ApplyCouponInitial extends ApplyCouponState {}

final class ApplyCouponLoading extends ApplyCouponState {}

final class ApplyCouponSuccess extends ApplyCouponState {}

final class ApplyCouponError extends ApplyCouponState {
  final ApiErrorModel error;
  ApplyCouponError(this.error);
}
