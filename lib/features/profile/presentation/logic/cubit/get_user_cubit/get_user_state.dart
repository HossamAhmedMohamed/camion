part of 'get_user_cubit.dart';

sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {}

final class GetUserLoaded extends GetUserState {
  final GetUserModel user;
  GetUserLoaded({required this.user});
}

final class GetUserError extends GetUserState {
  final ApiErrorModel error;
  GetUserError({required this.error});
}
