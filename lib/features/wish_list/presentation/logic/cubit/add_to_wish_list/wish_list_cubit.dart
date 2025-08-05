import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_list_state.dart';

class AddToWishListCubit extends Cubit<WishListState> {
  AddToWishListCubit(this.wishListRepository) : super(WishListInitial());
  final WishListRepository wishListRepository;

  addtoWishList({
    required String token,
    required String userId,
    required String productId,
    required String title,
    required int price,
    required String image,
  }) async {
    emit(WishListLoading());
    final result = await wishListRepository.addToWishList(
      token: token,
      userId: userId,
      productId: productId,
      title: title,
      price: price,
      image: image,
    );
    result.fold(
      (l) => emit(WishListError(error: l)),
      (r) => emit(WishListSuccess()),
    );
  }
}
