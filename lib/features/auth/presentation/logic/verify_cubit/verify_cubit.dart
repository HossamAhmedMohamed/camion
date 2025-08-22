import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/cache_helper.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/models/verify_model/verify_model.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit(this.authRepository) : super(VerifyInitial());
  final AuthRepository authRepository;

  Future<void> verify({required String code}) async {
    final email = await sl<SecureCacheHelper>().getData(key: 'email');
    final phoneNumber = await sl<SecureCacheHelper>().getData(
      key: 'phoneNumber',
    );
    emit(VerifyLoading());
    final result = await authRepository.verify(
      email: email!,
      phoneNumber: phoneNumber!,
      code: code,
    );
    result.fold((l) => emit(VerifyError(error: l)), (r) async {
      await Future.wait([
        sl<SecureCacheHelper>().saveData(key: 'token', value: r.accessToken),
        sl<SecureCacheHelper>().saveData(key: 'id', value: r.user.id),
        sl<SecureCacheHelper>().saveData(key: 'userRole', value: r.user.role),
        sl<CacheHelper>().saveData(key: 'userName', value: r.user.fullName),
      ]);
      emit(VerifyLoaded(verifyModel: r));
    });
  }
}
