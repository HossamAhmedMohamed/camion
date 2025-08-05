part of 'get_cart_cubit.dart';

sealed class GetCartState {}

final class GetCartInitial extends GetCartState {}

final class GetCartLoading extends GetCartState {}

final class GetCartSuccess extends GetCartState {
  final List<GetCartModel> cartList;
  GetCartSuccess(this.cartList);
}

final class GetCartError extends GetCartState {
  final ApiErrorModel error;
  GetCartError(this.error);
}
