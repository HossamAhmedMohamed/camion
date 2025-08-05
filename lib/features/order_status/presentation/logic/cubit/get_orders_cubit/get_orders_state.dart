part of 'get_orders_cubit.dart';

 
sealed class GetOrdersState {}

final class GetOrdersInitial extends GetOrdersState {}

final class GetOrdersLoading extends GetOrdersState {}

final class GetOrdersSuccess extends GetOrdersState {
  final List<OrderModel> orders;
  GetOrdersSuccess({required this.orders});
}

final class GetOrdersError extends GetOrdersState {
  final ApiErrorModel error;
  GetOrdersError({required this.error});
}
