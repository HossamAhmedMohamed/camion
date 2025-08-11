 

// import 'package:camion/core/api/api_error_model.dart';
// import 'package:camion/core/cache/secure_cache_storage.dart';
// import 'package:camion/core/services/service_locator.dart';
// import 'package:camion/features/wish_list/data/repository/wish_list_repo.dart';
// import 'package:camion/features/wish_list/presentation/logic/cubit/get_wish_listcubit/get_wish_list_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'remove_from_wish_list_state.dart';

// class RemoveFromWishListCubit extends Cubit<RemoveFromWishListState> {
//   RemoveFromWishListCubit(this.wishListRepository) : super(RemoveFromWishListInitial());
//   final WishListRepository wishListRepository;

//   Future<void> removeFromWishList({
   
//     required String productId,
//   }) async {
//     final token = await sl<SecureCacheHelper>().getData(key: 'token');
//     emit(RemoveWishListLoading());
//     final result = await wishListRepository.removeFromWishList(
//       token: token!,
//       productId: productId,
//     );
//     result.fold(
//       (l) => emit(RemoveWishListError(l)),
//       (r) => emit(RemoveWishListSuccess()),
//     );
//   }
// }
