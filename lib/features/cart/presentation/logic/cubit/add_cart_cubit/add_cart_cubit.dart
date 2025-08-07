import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  AddCartCubit(this.cartRepository) : super(AddCartInitial());
  final CartRepository cartRepository;

  Future<void> addToCart({
    required String productId,
    required String title,
    required String price,
    required String image,
    required int quantity,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');

    emit(AddCartLoading());
    final result = await cartRepository.addToCart(
      token: token!,

      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: quantity,
    );
    result.fold((l) => emit(AddCartError(l)), (r) => emit(AddCartSuccess()));
  }
}
