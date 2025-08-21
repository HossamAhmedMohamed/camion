part of 'send_user_shipping_address_cubit.dart';


sealed class SendUserShippingAddressState {}

final class SendUserShippingAddressInitial extends SendUserShippingAddressState {}

final class SendUserShippingAddressLoading extends SendUserShippingAddressState {}

final class SendUserShippingAddressLoaded extends SendUserShippingAddressState {}

final class SendUserShippingAddressError extends SendUserShippingAddressState {
  final ApiErrorModel error;
  SendUserShippingAddressError({required this.error});
}
