 

import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_cart_state.dart';

class UpdateCartCubit extends Cubit<UpdateCartState> {
  UpdateCartCubit(this.cartRepository) : super(UpdateCartInitial());

  final CartRepository cartRepository;

  Future<void> updateCart({
    required String productId,
    required int quantity,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(UpdateCartLoading());

    final result = await cartRepository.updateCart(
      token: token!,
      productId: productId,
      quantity: quantity,
    );

    result.fold((l) => emit(UpdateCartError(error: l)), (r) {
      emit(UpdateCartSuccess(getCartModel: r));
    });
  }

  Future<void> deleteFromCart({required String productId}) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(UpdateCartLoading()); 
    final result = await cartRepository.deleteFromCart(token: token!, productId: productId);
    result.fold((l) => emit(UpdateCartError(error: l)), (r) {
      emit(UpdateCartSuccess(getCartModel: r));
    }); 
  }
}
