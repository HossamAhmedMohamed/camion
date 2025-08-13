import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit(this.cartRepository) : super(GetCartInitial());
  final CartRepository cartRepository;
  Future<void> getCart() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetCartLoading());
    final result = await cartRepository.getCart(token: token!);
    if (isClosed) return;
    result.fold((l) => emit(GetCartError(l)), (r) => emit(GetCartSuccess(r)));
  }
}
