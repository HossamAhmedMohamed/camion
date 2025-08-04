part of 'verify_cubit.dart';

 
sealed class VerifyState {}

final class VerifyInitial extends VerifyState {}

final class VerifyLoading extends VerifyState {}

final class VerifyLoaded extends VerifyState {
  final VerifyModel loginModel;
  VerifyLoaded({required this.loginModel});
}

final class VerifyError extends VerifyState {
  final ApiErrorModel error;
  VerifyError({required this.error});
}
