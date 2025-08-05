part of 'add_cart_cubit.dart';

sealed class AddCartState {}

final class AddCartInitial extends AddCartState {}

final class AddCartLoading extends AddCartState {}

final class AddCartSuccess extends AddCartState {}

final class AddCartError extends AddCartState {
  final ApiErrorModel error;
  AddCartError(this.error);
}
