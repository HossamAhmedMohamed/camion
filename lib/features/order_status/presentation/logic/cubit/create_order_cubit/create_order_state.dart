part of 'create_order_cubit.dart';

sealed class CreateOrderState {}

final class CalculateShippingAddressLoading extends CreateOrderState {}

final class CalculateShippingAddressSuccess extends CreateOrderState {
  final List<ShippingMethodModel> shippingMethods;
  CalculateShippingAddressSuccess({required this.shippingMethods});
}

final class CalculateShippingAddressError extends CreateOrderState {
  final ApiErrorModel error;
  CalculateShippingAddressError({required this.error});
}


final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final OrderResponse order;
  CreateOrderSuccess({required this.order});
}

final class CreateOrderError extends CreateOrderState {
  final ApiErrorModel error;
  CreateOrderError({required this.error});
}
