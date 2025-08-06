import 'package:camion/core/api/api_error_model.dart';
import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepository) : super(LoginInitial());
  final AuthRepository authRepository;

  Future<void> login({
    required String email,
    required String phoneNumber,
  }) async {
    emit(LoginLoading());
    final result = await authRepository.login(
      email: email,
      phoneNumber: phoneNumber,
    );
    result.fold((l) => emit(LoginError(error: l)), (r) {
      sl<SecureCacheHelper>().saveData(key: 'email', value: email);
      sl<SecureCacheHelper>().saveData(key: 'phoneNumber', value: phoneNumber);
      emit(LoginLoaded(message: r));
    });
  }
}
