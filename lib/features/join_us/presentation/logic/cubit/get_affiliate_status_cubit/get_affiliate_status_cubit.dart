import 'dart:developer';

import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/join_us/data/models/affiliate_status/affiliate_status_model.dart';
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_affiliate_status_state.dart';

class GetAffiliateStatusCubit extends Cubit<GetAffiliateStatusState> {
  GetAffiliateStatusCubit(this.supplierRepository)
    : super(GetAffiliateStatusInitial());
  final AffiliateRepository supplierRepository;

  Future<void> getAffiliateStatus() async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (isClosed) return;
    emit(GetAffiliateStatusLoading());
    final result = await supplierRepository.getAffiliateStatus(token: token!);
    if (isClosed) return;
    result.fold(
      (l) {
        if (isClosed) return;
        emit(GetAffiliateStatusError(error: l));
      },
      (r) async {
        if (isClosed) return;
        if (r.status == "approved") {
          Future.wait([
            sl<SecureCacheHelper>().saveData(key: 'token', value: r.token!),
            sl<SecureCacheHelper>().saveData(
              key: 'AffiliateId',
              value: r.affiliateId,
            ),
          ]);

          log(r.token.toString());
        }
        emit(GetAffiliateStatusSuccess(data: r));
      },
    );
  }
}
