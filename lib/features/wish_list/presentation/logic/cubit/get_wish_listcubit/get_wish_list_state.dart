part of 'get_wish_list_cubit.dart';

sealed class GetWishListState {}

final class GetWishListInitial extends GetWishListState {}

final class GetWishListLoading extends GetWishListState {}

final class GetWishListSuccess extends GetWishListState {
  final List<GetWishListModel> wishLists;
  GetWishListSuccess(this.wishLists);
}

final class GetWishListError extends GetWishListState {
  final ApiErrorModel error;
  GetWishListError(this.error);
}
