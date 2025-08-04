part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterLoaded extends RegisterState {
  final RegisterModel registerModel;

  RegisterLoaded({required this.registerModel});
}

final class RegisterError extends RegisterState {
  final ApiErrorModel error;

  RegisterError({required this.error});
}
