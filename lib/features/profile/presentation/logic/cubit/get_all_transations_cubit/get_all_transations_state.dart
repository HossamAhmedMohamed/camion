part of 'get_all_transations_cubit.dart';

sealed class GetAllTransationsState {}

final class GetAllTransationsInitial extends GetAllTransationsState {}

final class GetAllTransationsLoading extends GetAllTransationsState {}

final class GetAllTransationsSuccess extends GetAllTransationsState {
  final List<Transactions> data;
  GetAllTransationsSuccess({required this.data});
}

final class GetAllTransationsError extends GetAllTransationsState {
  final ApiErrorModel error;
  GetAllTransationsError({required this.error});
}
