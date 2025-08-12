import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/join_us/data/models/affiliate_model/affiliate_model.dart';
import 'package:camion/features/join_us/data/repository/supplier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'supplier_sign_state.dart';

class SupplierSignCubit extends Cubit<SupplierSignState> {
  SupplierSignCubit(this.supplierRepository) : super(SupplierSignInitial());
  final SupplierRepository supplierRepository;

  Future<void> signSupplier({
    required String name,
    required String nationality,
    required String gender,
    required String bio,
  }) async {
    final token = await sl<SecureCacheHelper>().getData(key: 'token');
     
    emit(SupplierSignLoading());
    final result = await supplierRepository.signSupplier(
      token: token!,
      name: name,
      nationality: nationality,
      gender: gender,
      bio: bio,
       
    );
    result.fold((l) => emit(SupplierSignError(l)), (r) async {
      await sl<SecureCacheHelper>().saveData(key: 'affiliateId', value: r.id);

      emit(SupplierSignSuccess(affiliateModel: r));
    });
  }
}
