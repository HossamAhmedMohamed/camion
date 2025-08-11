part of 'add_cart_cubit.dart';

sealed class AddCartState {}

final class AddCartInitial extends AddCartState {}

final class AddCartLoading extends AddCartState {
  final String productId;
  AddCartLoading(this.productId);
}

final class AddCartSuccess extends AddCartState {
  final String productId;
  AddCartSuccess(this.productId);
}

final class AddCartError extends AddCartState {
  final ApiErrorModel error;
  final String productId;
  AddCartError(this.error , this.productId);
}
