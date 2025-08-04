import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:camion/features/auth/data/models/register_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepository) : super(RegisterInitial());
  final AuthRepository authRepository;

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());
    final result = await authRepository.register(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
    );
    result.fold((l) => emit(RegisterError(error: l)), (r) async {
      await Future.wait([
        sl<SecureCacheHelper>().saveData(key: 'email', value: r.email!),
        sl<SecureCacheHelper>().saveData(key: 'phoneNumber', value: r.phone!),
      ]);
      emit(RegisterLoaded(registerModel: r));
    });
  }
}
