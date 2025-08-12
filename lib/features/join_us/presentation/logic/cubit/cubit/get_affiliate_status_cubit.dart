import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_affiliate_status_state.dart';

class GetAffiliateStatusCubit extends Cubit<GetAffiliateStatusState> {
  GetAffiliateStatusCubit(this.supplierRepository)
    : super(GetAffiliateStatusInitial());
  final SupplierRepository supplierRepository;

  Future<void> getAffiliateStatus() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    emit(GetAffiliateStatusLoading());
    final result = await supplierRepository.getAffiliatePendings(token: token!);
    result.fold(
      (l) => emit(GetAffiliateStatusError(error: l)),
      (r) => emit(GetAffiliateStatusSuccess(data: r)),
    );
  }
}
