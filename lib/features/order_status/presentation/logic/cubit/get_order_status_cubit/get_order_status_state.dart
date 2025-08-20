part of 'get_order_status_cubit.dart';

sealed class GetOrderStatusState {}

final class GetOrderStatusInitial extends GetOrderStatusState {}

final class GetOrderStatusLoading extends GetOrderStatusState {}

final class GetOrderStatusSuccess extends GetOrderStatusState {
  final List<OrderModel> orders;
  GetOrderStatusSuccess({required this.orders});
}

final class GetOrderStatusError extends GetOrderStatusState {
  final ApiErrorModel error;
  GetOrderStatusError({required this.error});
}
