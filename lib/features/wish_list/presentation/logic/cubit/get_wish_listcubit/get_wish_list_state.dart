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

final class RemoveWishListLoading extends GetWishListState {}

final class RemoveWishListSuccess extends GetWishListState {}

final class RemoveWishListError extends GetWishListState {
  final ApiErrorModel error;
  RemoveWishListError(this.error);
}
