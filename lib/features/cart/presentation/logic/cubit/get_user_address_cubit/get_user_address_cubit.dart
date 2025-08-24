import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/models/get_user_address_model.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_user_address_state.dart';

class GetUserAddressCubit extends Cubit<GetUserAddressState> {
  GetUserAddressCubit(this.cartRepository) : super(GetUserAddressInitial());
  final CartRepository cartRepository;

  Future<void> getUserAddress() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetUserAddressLoading());
    final result = await cartRepository.getUserAddress(token: token!);
    if (isClosed) return;
    result.fold(
      (l) => emit(GetUserAddressError(error: l)),
      (r) => emit(GetUserAddressSuccess(data: r)),
    );
  }
}
