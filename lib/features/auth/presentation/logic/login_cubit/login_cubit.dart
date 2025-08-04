import 'package:camion/core/api/api_error_model.dart';
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
      emit(LoginLoaded(message: r));
    });
  }
}
