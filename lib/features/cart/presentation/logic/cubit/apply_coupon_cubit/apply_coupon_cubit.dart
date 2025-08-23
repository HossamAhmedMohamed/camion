import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/cart/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'apply_coupon_state.dart';

class ApplyCouponCubit extends Cubit<ApplyCouponState> {
  ApplyCouponCubit(this.cartRepository) : super(ApplyCouponInitial());
  final CartRepository cartRepository;

  Future<void> applyCoupon({required String code}) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(ApplyCouponLoading());
    final result = await cartRepository.applyCoupon(token: token!, code: code);
    result.fold(
      (l) => emit(ApplyCouponError(l)),
      (r) => emit(ApplyCouponSuccess()),
    );
  }
}
