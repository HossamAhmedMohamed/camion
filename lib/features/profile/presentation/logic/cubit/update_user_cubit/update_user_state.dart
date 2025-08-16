part of 'update_user_cubit.dart';


sealed class UpdateUserState {}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserLoaded extends UpdateUserState {
  final GetUserModel user;
  UpdateUserLoaded({required this.user});
}

final class UpdateUserError extends UpdateUserState {
  final ApiErrorModel error;
  UpdateUserError({required this.error});
}
