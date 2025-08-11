part of 'update_cart_cubit.dart';

sealed class UpdateCartState {}

final class UpdateCartInitial extends UpdateCartState {}

final class UpdateCartLoading extends UpdateCartState {}

final class UpdateCartSuccess extends UpdateCartState {
  GetCartModel getCartModel;
  UpdateCartSuccess({required this.getCartModel});
}

final class UpdateCartError extends UpdateCartState {
  final ApiErrorModel error;
  UpdateCartError({required this.error});
}

final class RemoveFromCartLoading extends UpdateCartState {}

final class RemoveFromCartSuccess extends UpdateCartState {
  GetCartModel getCartModel;
  RemoveFromCartSuccess({required this.getCartModel});
}

final class RemoveFromCartError extends UpdateCartState {
  final ApiErrorModel error;
  RemoveFromCartError({required this.error});
}
