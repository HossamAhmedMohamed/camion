import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  AddCartCubit(this.cartRepository) : super(AddCartInitial());
  final CartRepository cartRepository;

  Future<void> addToCart({
    required String token,
    required String userId,
    required String productId,
    required String title,
    required int price,
    required String image,
    required int quantity,
  }) async {
    emit(AddCartLoading());
    final result = await cartRepository.addToCart(
      token: token,
      userId: userId,
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: quantity,
    );
    result.fold((l) => emit(AddCartError(l)), (r) => emit(AddCartSuccess()));
  }
}
