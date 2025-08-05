import 'package:camion/core/api/api_error_model.dart';

import 'package:camion/features/wish_list/data/models/get_wish_list_model.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_wish_list_state.dart';

class GetWishListCubit extends Cubit<GetWishListState> {
  GetWishListCubit(this.wishListRepository) : super(GetWishListInitial());
  final WishListRepository wishListRepository;

  Future<void> getWishList({
    required String token,
    required String userId,
  }) async {
    emit(GetWishListLoading());
    final result = await wishListRepository.getWishList(
      token: token,
      userId: userId,
    );
    result.fold(
      (l) => emit(GetWishListError(l)),
      (r) => emit(GetWishListSuccess(r)),
    );
  }
}
