import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';

import 'package:camion/features/wish_list/data/models/get_wish_list_model.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_wish_list_state.dart';

class GetWishListCubit extends Cubit<GetWishListState> {
  GetWishListCubit(this.wishListRepository) : super(GetWishListInitial());
  final WishListRepository wishListRepository;

  Future<void> getWishList() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetWishListLoading());
    final result = await wishListRepository.getWishList(token: token!);
    if (isClosed) return;
    result.fold(
      (l) => emit(GetWishListError(l)),
      (r) => emit(GetWishListSuccess(r)),
    );
  }

  Future<void> removeFromWishList({
   
    required String productId,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(RemoveWishListLoading());
    final result = await wishListRepository.removeFromWishList(
      token: token!,
      productId: productId,
    );
    result.fold(
      (l) => emit(RemoveWishListError(l)),
      (r) => emit(RemoveWishListSuccess()),
    );
  }

  
}
