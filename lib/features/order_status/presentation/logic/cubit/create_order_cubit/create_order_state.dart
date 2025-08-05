part of 'create_order_cubit.dart';

sealed class CreateOrderState {}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {}

final class CreateOrderError extends CreateOrderState {
  final ApiErrorModel error;
  CreateOrderError({required this.error});
}
