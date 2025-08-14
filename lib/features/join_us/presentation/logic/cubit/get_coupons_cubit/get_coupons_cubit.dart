import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/join_us/data/models/coupons_model/get_coupons_model.dart'
    show GetCouponsModel;
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_coupons_state.dart';

class GetCouponsCubit extends Cubit<GetCouponsState> {
  GetCouponsCubit(this.supplierRepository) : super(GetCouponsInitial());
  final AffiliateRepository supplierRepository;

  Future<void> getCouponCodeByAffiliateId() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) {
      return;
    }
    emit(GetCouponsLoading());
    final result = await supplierRepository.getCouponCodeByAffiliateId(
      token: token!,
    );
    if (isClosed) {
      return;
    }
    result.fold(
      (l) => emit(GetCouponsError(error: l)),
      (r) => emit(GetCouponsSuccess(coupons: r)),
    );
  }
}
