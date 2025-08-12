import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_coupon_state.dart';

class CreateCouponCubit extends Cubit<CreateCouponState> {
  CreateCouponCubit(this.supplierRepository) : super(CreateCouponInitial());
  final SupplierRepository supplierRepository;

  Future<void> createCoupon({
    required String code,
    required String discountPercentage,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(CreateCouponLoading());
    final result = await supplierRepository.createCoupon(
      token: token!
           ,
      code: code,
      discountPercentage: discountPercentage,
    );
    result.fold(
      (l) => emit(CreateCouponError(error: l)),
      (r) => emit(CreateCouponSuccess()),
    );
  }
}
