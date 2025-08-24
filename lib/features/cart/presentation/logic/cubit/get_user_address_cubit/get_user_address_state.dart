part of 'get_user_address_cubit.dart';

sealed class GetUserAddressState {}

final class GetUserAddressInitial extends GetUserAddressState {}

final class GetUserAddressLoading extends GetUserAddressState {}

final class GetUserAddressSuccess extends GetUserAddressState {
  final GetUserAddressModel data;
  GetUserAddressSuccess({required this.data});
}

final class GetUserAddressError extends GetUserAddressState {
  final ApiErrorModel error;
  GetUserAddressError({required this.error});
}
