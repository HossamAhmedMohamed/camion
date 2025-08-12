part of 'wish_list_cubit.dart';

sealed class AddToWishListState {}

final class WishListInitial extends AddToWishListState {}

final class WishListLoading extends AddToWishListState {
  final String productId;
  WishListLoading({required this.productId});
}

final class WishListSuccess extends AddToWishListState {
  final String productId;
  WishListSuccess({required this.productId});
}

final class WishListError extends AddToWishListState {
  final ApiErrorModel error;
  final String productId;
  WishListError({required this.error , required this.productId});
}
