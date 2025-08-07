import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_list_state.dart';

class AddToWishListCubit extends Cubit<WishListState> {
  AddToWishListCubit(this.wishListRepository) : super(WishListInitial());
  final WishListRepository wishListRepository;

  addtoWishList({
   
    required String productId,
    required String title,
    required String price,
    required String image,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(WishListLoading());
    final result = await wishListRepository.addToWishList(
      token: token!,
     
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
